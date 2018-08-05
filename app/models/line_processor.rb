class LineProcessor
  def initialize(slink, browser)
    @slink = slink
    @browser = browser
  end

  def perform
    agent = Mechanize.new
    agent.user_agent_alias = @browser #use a random alias :)
      if (Rails.env.development? | Rails.env.test?)
        run_identifier = Run.find_or_create_by(run_identifier: @slink[@slink.index('4567')+5 .. @slink.index('/results')-1])
        Rails.logger.info "LP:Development The Link is: #{run_identifier.run_identifier} "
      else
        run_identifier = @slink[@slink.index('parkrun') .. @slink.index('/results')-1]
        run_identifier = run_identifier[run_identifier.index('/')+1..run_identifier.length]
        run_identifier = Run.find_or_create_by(run_identifier: run_identifier)
        Rails.logger.info "LP:Production The Link is: #{run_identifier.run_identifier} "
      end
      agent = Mechanize.new
      agent.user_agent_alias = @browser

      begin
        slink_doc = agent.get(@slink)
        slink_doc.xpath('//tr').each do |row|  # this is the loop for individual rows of data.
          begin
            if row.children.length > 8  && row.children[0].children.text != '' && (!row.children[1].children.text.include? 'parkrunner')
                time_in_seconds = row.children[2].children.text.split(':')[-1].to_i + row.children[2].children.text.split(':')[-2].to_i*60  + row.children[2].children.text.split(':')[-3].to_i*3600
                result = Result.create(
                  pos:            row.children[0].children.text,
                  parkrunner:     row.children[1].children.text,
                  time:           time_in_seconds,
                  age_cat:        row.children[3].children.text,
                  age_grade:      row.children[4].children.text,
                  gender:         row.children[5].children.text,
                  gender_pos:     row.children[6].children.text,
                  club:           row.children[7].children.text,
                  note:           row.children[8].children.text,
                  total:          row.children[9].children.text,
                  run_id:         run_identifier.id,
                  athlete_number: get_runner_number_from_text(row) || nil
                  )
                if ([49, 99, 149, 199, 249, 299, 349, 399, 449, 499, 549, 599, 649].include? result.total) && (run_identifier.run_identifier.include? 'astleigh' or result.club.include? 'astleigh')
                  milestone = Milestone.find_or_create_by(result.attributes.except('id', 'created_at', 'updated_at'))
                elsif  [9].include? result.total && (result.age_cat.include? 'J')
                  milestone=Milestone.find_or_create_by(result.attributes.except('id', 'created_at', 'updated_at'))
                elsif ([10, 50, 100, 200, 250, 300, 350, 400, 450, 500, 550, 600, 650].include? result.total)
                  result_to_clear = Milestone.find_by athlete_number: result.athlete_number if Milestone.exists?(:athlete_number => result.athlete_number)
                  if(result_to_clear)
                    result_to_clear.destroy
                  end
                end
            end   # here ends each row operation
          rescue StandardError => e
            Rails.logger.log "LP: An individual scraping error occurred, #{e}, Run Was: #{run_identifier.id}"
          end # rescue block
        end # here ends the slink each
        Rails.logger.debug "LP: Success one scrape"
        run = Run.find(run_identifier.id); run.metadata['comment']=nil; run.save!
      rescue StandardError => e
        Rails.logger.debug "LP: Failed one scrape, #{e}"
        run = Run.find(run_identifier.id); run.metadata['comment']='Failed to get data'; run.save!
        Resque.enqueue(Alerter, "Line Processor Failed to get run data for this run:  #{run_identifier.run_identifier}")
      end
    end  # here ends each link for scraping

    def get_runner_number_from_text(inputrow)
      runnerstring = inputrow.children[1].children.text
      if (runnerstring.include? 'Unknown')
        return nil
      else
        athletestring = inputrow.children[1].children[0].attributes['href'].try(:value)
        if(athletestring)
          athlete_number = athletestring[athletestring.index('ber=')+4, athletestring.length].to_i
          return athlete_number
        else
          return 'no_number'
        end
      end
    end
end
