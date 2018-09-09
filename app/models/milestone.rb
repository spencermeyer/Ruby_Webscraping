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
  def athlete_online_link
    'http://www.parkrun.org.uk/results/athleteresultshistory/?athleteNumber=' + athlete_number
  end
end
