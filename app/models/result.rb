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

  def gender_pos_class
    gender_pos.to_i < 13 ? 'gender-pos-high' : 'normal-gender-pos'
  end

  def gender_win_class
    gender_pos == '1' ? 'gender-pos-win' : 'normal-gender-pos'
  end

  def milestone_run_class
    [50, 100, 150, 200, 250, 300, 350, 400, 450, 500, 550, 600].include?(total) ? 'milestone-run' : 'not-milestone'
  end

  def age_cat_class
    age_cat_position == 1 ? 'first-in-age-cat' : 'normal-age-cat'
  end

  def age_class  
    age_grade.to_f > 70 ? 'fast-age' : 'not-fast-age'
  end

  def high_age_pos_finisher
    age_grade_position < 13 ? 'high_age_pos_finisher' : 'normal_age_pos_finisher'
  end

  def high_pos_finisher
    pos < 2 ? 'high_pos_finisher' : 'normal_pos_finisher'
  end

  def note_class
    # note = self.note.chomp
    # closepb = false
    # if note.include?('PB') && !note.include?('New PB')
    #   pb_time_array = note.gsub('PB', '').split(':').inject([]) { |memo, part| memo << part.to_i }
    #   pb_in_seconds = pb_time_array[2] + ( 60 * pb_time_array[1]) + ( 3600 * pb_time_array[0])
    #   closepb = time - pb_in_seconds < 5
    # end

    # note.include?('First Timer!') ? 'note' : \
    # note.include?('New PB!') ? 'newpb' : \
    # closepb ? 'close-pb' : 'note'
    ''
  end

  def populated_result?
    !pos.nil? && !age_grade_position.nil? && !age_grade.empty? && !age_cat_position.nil? && !total.nil? && !gender_pos.empty?
  end
end
