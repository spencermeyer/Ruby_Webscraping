class StalkeeIndividualProcessor
  @queue = :line_processor

  def self.perform(hash)
    @browser = hash['args_hash']['browser']
    @stalkee_link = hash['args_hash']['stalkee_personal_link']

    agent = Mechanize.new
    agent.user_agent_alias = @browser
    doc = agent.get(@stalkee_link)

    if doc.css("#results")[2].css('th').children[0].text.include?('Run Date')
      # when run date is the first column.
      run_date = Time.zone.parse(doc.css("#results")[2].css('td').first.children.first.children.text)
      link = doc.css("#results")[2].css('td').first.children.first.attributes['href'].value
      Rails.logger.debug "AWOOGA FROM INDIVIDUAL PROCESSOR LINK IS : #{link}"
    elsif doc.css("#results")[2].css('th').children[1].text.include?('Run Date')
      # when run date is the second column.
      run_date = Time.zone.parse(doc.css("#results")[2].css('td').children[1].children.text)
      link = doc.css("#results")[2].css('td').children[0].attributes['href'].value
      Rails.logger.debug "AWOOGA FROM INDIVIDUAL PROCESSOR LINK IS : #{link}"
    else
      run_date = false
    end

    if run_date && (Date.today - Date.parse(run_date).to_i) <= 6 || Rails.env=="development"
      Rails.logger.debug "ENQUEUEING A STALKEE LINE LINK IS: #{link}"
      if !Run.any? { |run| run.run_identifier == get_run_identifier_from_link(link) && run.updated_at > (Date.today -0.5) }
        Resque.enqueue_at(
          Time.now + 5.seconds,
          LineProcessor,
          args_hash: {
            slink: link,
            browser: Browserchoice::Browserchoices.random_alias}
          )
      end
    end
  end

  def get_run_identifier_from_link(link)
    link[link.index('org.uk/')+7..link.index('/results')-1]
  end
end
