require 'rails_helper'
require 'vcr'
require 'webmock'
include ScrapesHelper

RSpec.describe ScrapesController, type: :controller do
  VCR.configure do |config|
    config.cassette_library_dir = "spec/fixtures/vcr_cassettes"
    config.hook_into :webmock
  end

  let(:rescue) { double('Resque') }

  describe "GET #scrape" do
    it "visits the scrapes route and initiates the clean job" do
      VCR.use_cassette('scrape', record: :none) do  #record: :new_episodes :all :none
        
        expect(Resque).to receive(:enqueue).with(ScrapesHelper::UnusedRuns)

        get :index
      end
    end
  end
end