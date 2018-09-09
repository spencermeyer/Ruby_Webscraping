require 'rails_helper'
require 'single_milestone_clean_delayed_job' # why?

RSpec.describe SingleMileStoneCleanDelayedJob, type: :model do
  VCR.configure do |config|
    config.cassette_library_dir = "spec/fixtures/vcr_cassettes"
    config.hook_into :webmock
    #config.debug_logger= File.open('vcr_debug.md', 'w')
  end

  describe '.perform' do
    context 'An out of sync milestone' do
      it 'cleans all milestone that are not the same as on line' do
        VCR.use_cassette('clean', record: :none, allow_playback_repeats: true) do  #record: :new_episodes :all :none

          ms1 = Milestone.create(parkrunner: 'elvis PRESLEY', total:56, athlete_number: 129985)

          # allow(subject).to receive(:get_total_runs_from_online).and_return(57)
          # expect(subject).to be_valid
          # expect(subject).to receive(:destroy)
          expect(Milestone.all.count).to eq(1)
          described_class.perform({'number' => 129985})
          expect(Milestone.all.count).to eq(0)
        end
      end
    end

    context 'An in sync milestone' do
      it 'cleans all milestone that are not the same as on line' do
        VCR.use_cassette('clean', record: :none, allow_playback_repeats: true) do  #record: :new_episodes :all :none

          ms1 = Milestone.create(parkrunner: 'elvis PRESLEY', total:195, athlete_number: 159985)

          # allow(subject).to receive(:get_total_runs_from_online).and_return(57)
          # expect(subject).to be_valid
          # expect(subject).to receive(:destroy)
          expect(Milestone.all.count).to eq(1)
          described_class.perform({'number' => 159985})
          expect(Milestone.all.count).to eq(1)
        end
      end
    end
  end
end
