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
        results = []
        slink_doc = agent.get(@slink)
        slink_doc.xpath('//tr').each do |row|  # this is the loop for individual rows of data.
          begin
            if row.children.length > 8  && row.children[0].children.text != '' && (!row.children[1].children.text.include? 'parkrunner')
              time_in_seconds = row.children[2].children.text.split(':')[-1].to_i + row.children[2].children.text.split(':')[-2].to_i*60  + row.children[2].children.text.split(':')[-3].to_i*3600
              result = {
                pos:            row.children[0].children.text.to_i,
                parkrunner:     row.children[1].children.text,
                time:           time_in_seconds,
                age_cat:        row.children[3].children.text,
                age_grade:      row.children[4].children.text,
                gender:         row.children[5].children.text,
                gender_pos:     row.children[6].children.text,
                club:           row.children[7].children.text,
                note:           row.children[8].children.text,
                total:          row.children[9].children.text.to_i,
                run_id:         run_identifier.id,
                athlete_number: get_runner_number_from_text(row) || nil
                }
              if ([49, 99, 149, 199, 249, 299, 349, 399, 449, 499, 549, 599, 649].include? result[:total]) && (run_identifier.run_identifier.include? 'astleigh' or result[:club].include? 'astleigh')
                create_milestone_from_result_hash(result)
              elsif  [9].include? result[:total] && (result[:age_cat].include? 'J')
                create_milestone_from_result_hash(result)
              elsif ([10, 50, 100, 200, 250, 300, 350, 400, 450, 500, 550, 600, 650].include? result[:total])
                result_to_clear = Milestone.find_by athlete_number: result[:athlete_number] if Milestone.exists?(:athlete_number => result[:athlete_number])
                  result_to_clear.destroy if(result_to_clear)
              end
            end   # here ends each row operation
          rescue StandardError => e
            Rails.logger.log "LP: An individual scraping error occurred, #{e}, Run Was: #{run_identifier.id}"
          end # rescue block
          results.push(result) if result
        end # here ends the slink each
        Rails.logger.debug "LP: Success one scrape"

        # Sort by age grade and allocate age grade positions
        results = results.sort_by{|res| res[:age_grade]}.reverse!
        results.each_with_index { |val, index| val[:age_grade_position] = index +1 }

        # Batch into age categories and allocate age cat positions
        results = results.group_by{ |i| i[:age_cat] }
        run = Run.find(run_identifier.id)   # DNC
        results = results.each_pair { |k, v| assign_age_cat_pos_to_array_of_hashes(v) }
        results = results.values.flatten
 
        Result.create(results)
        run = Run.find(run_identifier.id); run.metadata['comment']=nil; run.save!
      rescue StandardError => e
        Rails.logger.debug "LP: Failed one scrape, #{e}"
        run = Run.find(run_identifier.id); run.metadata['comment']='Failed to get data'; run.save!
        Resque.enqueue(Alerter::MailGunAlerter, "Line Processor Failed to get run data for this run:  #{run_identifier.run_identifier}")
      end
    end

    private

    def assign_age_cat_pos_to_array_of_hashes(arry)
      arry = arry.sort_by{ |elem| elem[:time] }
      arry = arry.each_with_index { |val, index| val[:age_cat_position] = index + 1  }
      arry
    end

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

    def create_milestone_from_result_hash(result)
      milestone = Milestone.where(parkrunner: result[:parkrunner], athlete_number: result[:athlete_number]).first_or_create do |milestone|
        milestone.pos        = result[:pos]
        milestone.time       = result[:time]
        milestone.age_cat    = result[:age_cat]
        milestone.age_grade  = result[:age_grade]
        milestone.gender     = result[:gender]
        milestone.gender_pos = result[:gender_pos]
        milestone.club       = result[:club]
        milestone.note       = result[:note]
        milestone.total      = result[:total]
        milestone.run_id     = result[:run_id]
        milestone.run_id     = result[:run_id]
      end
      milestone.save!
    end
end
