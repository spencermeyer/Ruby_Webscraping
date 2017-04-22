# == Schema Information
#
# Table name: results
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
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  run_id             :integer
#  age_grade_position :integer
#  age_cat_position   :integer
#  athlete_number     :integer
#

class Result < ApplicationRecord
  belongs_to :run
  @stalkees = Stalkee.pluck(:parkrunner)
  scope :eastleigh, -> { where(club: 'Eastleigh RC') }
  scope :stalkees, -> { where(parkrunner: @stalkees )}
  scope :eastleigh_and_stalkees, -> { where(club: 'Eastleigh RC').or where(parkrunner: @stalkees) }
  scope :top12s, -> { where("age_grade_position < ?", 13 )}
end