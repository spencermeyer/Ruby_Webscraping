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

require 'rails_helper'

RSpec.describe Milestone, type: :model do
  # skip 'nothing to rest in the milestones model yet' do
    # pending "add some examples to (or delete) #{__FILE__}"
  # end

  describe '.clean' do
    subject {described_class.new(id: 2, parkrunner: 'elvis PRESLEY', total:56)}
    it 'cleans runs that are not updated' do
      allow(subject).to receive(:get_total_runs_from_online).and_return(57)
      expect(subject).to be_valid
      subject.clean
    end
  end
end
