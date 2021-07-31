class SingleMileStoneCleanDelayedJob
  require 'browserchoice'
  @queue = :singlemilestonecleaner
 
  class SingleMilestoneCleanerDelayedJobError < StandardError; end

  def self.perform(args)
    # here args is e.g.  {"number"=>"316723"}
    Rails.logger.debug "SMCJ AWOOGA #{args['number']}"
    ms = Milestone.find_by_athlete_number(args['number'])
    ms.destroy unless ms.total == get_total_runs_from_online(ms.athlete_number)

  end

  def self.get_total_runs_from_online(ms_number)
    agent = Mechanize.new
    agent.user_agent_alias = Mechanize::AGENT_ALIASES.to_a.sample
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