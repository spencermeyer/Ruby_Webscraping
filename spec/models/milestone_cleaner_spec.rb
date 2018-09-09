require 'rails_helper'

RSpec.describe MilestoneCleaner, type: :model do
  VCR.configure do |config|
    config.cassette_library_dir = "spec/fixtures/vcr_cassettes"
    config.hook_into :webmock
    #config.debug_logger= File.open('vcr_debug.md', 'w')
  end

  describe '.clean' do
    context 'It queues up clean jobs' do
      it'does three milestones' do
        ms1 = Milestone.create(parkrunner: 'elvis PRESLEY', total:56, athlete_number: 129985)
        ms1 = Milestone.create(parkrunner: 'james BOND', total:07, athlete_number: 007007)
        ms1 = Milestone.create(parkrunner: 'mickey MOUSE', total:99, athlete_number: 129986)

        expect(Resque).to receive(:enqueue_at).exactly(3).times.and_return(true)
        described_class.clean
      end
    end
  end
end
