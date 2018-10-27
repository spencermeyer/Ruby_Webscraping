class StalkeeProcessor
  include Browserchoice
  @queue = :line_processor

  def self.perform
    # @browser = hash['args_hash']['browser']
    @browser = Browserchoice::Browserchoices.random_alias

    agent = Mechanize.new
    agent.user_agent_alias = @browser

    stalkees_personal_links.each_with_index do |link, index|
      Resque.enqueue_at(
        Time.now + (index * 10).seconds,
        StalkeeIndividualProcessor,
        args_hash: {
          browser: Browserchoice::Browserchoices.random_alias,
          stalkee_personal_link: link
        }
        )
    end
  end

  def self.stalkees_personal_links
    arry = []
    Stalkee.all.each do |stalkee|
      if (Rails.env.development? | Rails.env.test?)
        # arry.push 'http:127.0.0.1:4567/eastleigh/results/athletehistory/athleteNumber' + stalkee.athlete_number.to_s
        arry.push URI.parse(URI.encode('http://127.0.0.1:4567/eastleigh/results/athletehistory/athleteNumber300613'))
      else
        arry.push 'http://www.parkrun.org.uk/eastleigh/results/athletehistory/?athleteNumber=' + stalkee.athlete_number.to_s
      end
    end
    arry
  end
end