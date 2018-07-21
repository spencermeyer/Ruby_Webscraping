# == Schema Information
#
# Table name: milestones
#
#  id                 :integer          not null, primary key
#  pos                :integer
#  parkrunner         :string
#  time               :string
#  age_cat            :string
#  age_grade          :string
#  gender             :string
#  gender_pos         :string
#  club               :string
#  note               :string
#  total              :integer
#  run_id             :integer
#  age_grade_position :integer
#  age_cat_position   :integer
#  athlete_number     :string
#  integer            :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

class Milestone < ApplicationRecord
  class MilestoneCleanerError < StandardError; end

  def clean
    puts 'Hi, cleaning', id
    self.destroy unless total == get_total_runs_from_online
  end

  def athlete_online_link
    'http://www.parkrun.org.uk/results/athleteresultshistory/?athleteNumber=' + athlete_number.to_s
  end

  def get_total_runs_from_online
    agent = Mechanize.new
    agent.user_agent_alias = ApplicationHelper::OtherBrowsers::ALIASES.sample
    begin
      doc = agent.get(athlete_online_link)
      string  = doc.xpath('//h2[contains(text(),"parkruns")]').text
      number = string[string.index('(')+1, string.index('parkruns')-16].to_i
    rescue MilestoneCleanerError => e
      Rails.logger.debug "Error in cleaning, #{e}"
    end
    number
  end
end
