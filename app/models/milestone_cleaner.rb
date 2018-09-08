class MilestoneCleaner
  require 'scrapes/browserchoice'

  class MilestoneCleanerError < StandardError; end

  def self.clean
    puts 'Milestones cleaning'
    Milestone.all.each do |ms|
      ms.destroy unless ms.total == get_total_runs_from_online(ms.athlete_number)
    end
  end

  # private

  def self.get_total_runs_from_online(ms_number)
    agent = Mechanize.new
    agent.user_agent_alias = Browserchoice::Browserchoices.random_alias
    begin
      doc = agent.get(athlete_online_link(ms_number))
      string  = doc.xpath('//h2[contains(text(),"parkruns")]').text
      number = string[string.index('(')+1, string.index('parkruns')-14].to_i
    rescue MilestoneCleanerError => e
      Rails.logger.debug "Error in cleaning, #{e}"
    end
    number
  end

  def self.athlete_online_link(ms_number)
    'http://www.parkrun.org.uk/results/athleteresultshistory/?athleteNumber=' + ms_number
  end
end
