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

  def note_class
    note = self.note.chomp
    closepb = false
    if note.include?('PB stays at')
      pb_in_seconds = self.note[-2..-1].to_i + ( 60 * self.note[-5..-4].to_i ) + ( 3600 * self.note[-8..-7].to_i) 
      closepb = self.time - pb_in_seconds < 10
    end

    note.include?('First Timer!') ? 'notex' : \
    note.include?('New PB!') ? 'newpb' : \
    closepb ? 'close-pb' : 'note'
  end
end

