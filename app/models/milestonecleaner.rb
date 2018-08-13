class Milestonecleaner
  class MilestoneCleanerError < StandardError; end

  def clean
    puts 'Milestones cleaning'
    Milestone.all.each do |ms|
      ms.destroy unless ms.total == get_total_runs_from_online(ms)
    end
  end

  private

  def get_total_runs_from_online
    agent = Mechanize.new
    agent.user_agent_alias = Browserchoice::Browserchoices::ALIASES.sample
    begin
      doc = agent.get(athlete_online_link)
      string  = doc.xpath('//h2[contains(text(),"parkruns")]').text
      number = string[string.index('(')+1, string.index('parkruns')-16].to_i
    rescue MilestoneCleanerError => e
      Rails.logger.debug "Error in cleaning, #{e}"
    end
    number
  end

  def athlete_online_link
    'http://www.parkrun.org.uk/results/athleteresultshistory/?athleteNumber=' + athlete_number.to_s
  end
end
