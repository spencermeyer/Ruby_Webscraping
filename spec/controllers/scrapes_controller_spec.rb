require 'rails_helper'
require 'vcr'
require 'webmock'

RSpec.describe ScrapesController, type: :controller do
  VCR.configure do |config|
    config.cassette_library_dir = "spec/fixtures/vcr_cassettes"
    config.hook_into :webmock
    #config.debug_logger= File.open('vcr_debug.md', 'w')
  end

  describe "GET #scrape" do
    it "scrapes the test website using vcr and generates results" do
      VCR.use_cassette('scrape', record: :new_episodes) do  #record: :new_episodes :all :none
        get :index
        expect(Result.count).to eq(3266)
        expect(Milestone.count).to eq(4)
      end
    end
  end
end