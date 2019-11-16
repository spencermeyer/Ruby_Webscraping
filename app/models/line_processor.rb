class LineProcessor
  @queue = :line_processor

  def self.perform(hash)
    @slink = hash['args_hash']['slink']
    @slink.sub!('https', 'http') if (Rails.env.development? || Rails.env.test?)
    @browser = hash['args_hash']['browser']

    agent = Mechanize.new
    agent.user_agent_alias = @browser

    run_identifier_text = @slink[@slink.index('parkrun') .. @slink.index('/results')-1]
    run_identifier_name = run_identifier_text[run_identifier_text.index('/')+1..run_identifier_text.length]
    run_identifier = Run.find_or_create_by(run_identifier: run_identifier_name)
    Rails.logger.info "LP:#{Rails.env} The Link is: #{@slink}"

    begin
      results = []
      slink_doc = agent.get(@slink)
      slink_doc.xpath('//tr[not(th)]').each do |row|
        begin
            next if row.children[1].css('div.compact').text=='Unknown'

            time_string = row.children[5].css('div.compact').text
            time_in_seconds = time_string.split(':')[-1].to_i + time_string.split(':')[-2].to_i*60  + time_string.split(':')[-3].to_i*3600
            result = {
              pos:            row.children[0].children.text.to_i,
              parkrunner:     row.children[1].css('div.compact a').text,
              time:           time_in_seconds,
              age_cat:        row.children[3].css('div.compact').text,
              age_grade:      row.children[3].css('div.detailed').text.split('%')[0] || nil,
              gender:         row.children[2].css('div.compact').text.delete("\n")&.strip || nil,
              gender_pos:     row.children[2].css('div.detailed').text.split('/')[0]&.to_i || nil,
              club:           row.children[4].css('div.compact')&.text || nil,
              note:           row.children[5].css('div.detailed')&.text || nil,
              total:          row.children[1].css('div.detailed')&.text&.split("\n")[0]&.strip&.to_i || nil,
              run_id:         run_identifier.id,
              athlete_number: row.children[1].css('div.compact a')[0]&.attributes['href']&.value&.partition('athleteNumber=')&.last&.to_i || nil
              }
            if ([49, 99, 149, 199, 249, 299, 349, 399, 449, 499, 549, 599, 649].include? result[:total]) && (run_identifier.run_identifier.include? 'astleigh' or result[:club].include? 'astleigh')
              create_milestone_from_result_hash(result)
            elsif  [9].include? result[:total] && (result[:age_cat].include? 'J')
              create_milestone_from_result_hash(result)
            elsif ([10, 50, 100, 200, 250, 300, 350, 400, 450, 500, 550, 600, 650].include? result[:total])
              result_to_clear = Milestone.find_by athlete_number: result[:athlete_number] if Milestone.exists?(:athlete_number => result[:athlete_number])
                result_to_clear.destroy if(result_to_clear)
            end 
            Rails.logger.debug "LPRR success one row for #{run_identifier_name} and "
          # end   # here ends each row operation
        rescue StandardError => e
          Rails.logger.debug "LPRN: An individual scraping error occurred error is: #{e.backtrace}, Run Was: #{run_identifier_name}?"
        end # rescue block
        results.push(result) if result
      end # here ends the slink each
      Rails.logger.debug "LP: Success one scrape for #{run_identifier_name}"
      # Sort by age grade and allocate age grade positions
      results = results.sort_by{|res| res[:age_grade]}.reverse!
      results.each_with_index { |val, index| val[:age_grade_position] = index +1 }

      # Batch into age categories and allocate age cat positions
      results = results.group_by{ |i| i[:age_cat] }

      results = results.each_pair { |k, v| assign_age_cat_pos_to_array_of_hashes(v) }
      results = results.values.flatten

      Result.create(results)
      run = Run.find(run_identifier.id); run.metadata['comment']=nil; run.save!
    rescue StandardError => e
      Rails.logger.debug "LP: Failed one scrape at #{Time.now}, #{e} #{e.backtrace}"
      run = Run.find(run_identifier.id); run.metadata['comment']="Failed to get data, #{e}"; run.save!
      Resque.enqueue(Alerter::SlackAlerter, "Line Processor Failed to for:  #{run_identifier.run_identifier}")
    end
  end  # end of perform method.

  def self.assign_age_cat_pos_to_array_of_hashes(arry)
    arry = arry.sort_by{ |elem| elem[:time] }
    arry = arry.each_with_index { |val, index| val[:age_cat_position] = index + 1  }
    arry.each { |elem| elem[:number_in_age_category] = arry.length }
    arry
  end

  def self.create_milestone_from_result_hash(result)
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
