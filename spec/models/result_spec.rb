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

require 'rails_helper'

RSpec.describe Result, type: :model do
  context 'Correct Application of pb class' do
    it 'correctly identifies a normal result' do
      result1 = Result.create(note: 'PB stays at 00:30:00', time: 5854)

      expect(result1.note_class).to eq('note')
    end
    it 'correctly identifies a new PB' do
      result2 = Result.create(note: 'New PB!', time: 5854)

      expect(result2.note_class).to eq('newpb')
    end
    it 'correctly identifies a near PB' do
      result2 = Result.create(note: 'PB stays at 00:17:55', time: 1083)

      expect(result2.note_class).to eq('close-pb')
    end
    it 'correctly assigns first timers' do
      result2 = Result.create(note: 'First Timer!', time: 5854)

      expect(result2.note_class).to eq('note')
    end
  end

  context 'Correct Identification of populated results' do
    it 'identifies populated results' do
      result3 = Result.create(
          pos: 1,
          parkrunner: 'Dan BCooper',
          time: 1378,
          age_cat: "VM60-64",
          age_grade: "85.70 %",
          gender: "M",
          gender_pos: "11",
          club: "LA Parachutists Club",
          note: "PB stays at 00:21:45",
          total: 147,
          run_id: 240,
          age_grade_position: 1,
          age_cat_position: 1,
          athlete_number: 544429)

      expect(result3.populated_result?).to be(true)
    end

    it 'identifies empty results' do
      result4 = Result.create(
          pos: 291,
          parkrunner: "Unknown",
          time: 0,
          age_cat: "",
          age_grade: "",
          gender: "",
          gender_pos: "",
          club: "",
          note: "",
          total: 0,
          run_id: 248,
          age_grade_position: 383,
          age_cat_position: 1,
          athlete_number: nil)

      expect(result4.populated_result?).to be(false)
    end
  end
end