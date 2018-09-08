require 'rails_helper'

#todo associate a milestone and check

RSpec.describe ScrapesHelper::UnusedRuns, type: :helper do
  describe '.perform' do
    it 'cleans runs that have no associated results' do
      run1 = Run.create(run_identifier: 'run_with_no_people')
      run2 = Run.create(run_identifier: 'run_with_people')
      res = Result.create(parkrunner: 'elvis PRESLEY', total:56, run_id: run2.id).save!
      described_class.perform

      expect(Run.all.count).to eq(1)
      expect(Run.first.run_identifier).to eq('run_with_people')
    end
  end
end