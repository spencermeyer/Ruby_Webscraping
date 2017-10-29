require 'rails_helper'
require 'vcr'
require 'webmock'
include ScrapesHelper

RSpec.describe ScrapesController, type: :controller do
  VCR.configure do |config|
    config.cassette_library_dir = "spec/fixtures/vcr_cassettes"
    config.hook_into :webmock
    #config.debug_logger= File.open('vcr_debug.md', 'w')
  end

  describe "GET #scrape" do
    it "scrapes the test website using vcr and generates results" do
      VCR.use_cassette('scrape', record: :none) do  #record: :new_episodes :all :none
        get :index
        expect(Result.count).to eq(3266)
        expect(Milestone.count).to eq(4)
        eastleigh_run=Run.where('run_identifier':'eastleigh').first
        expect(Result.where({'age_cat':'VW50-54', 'club':'Eastleigh RC', run_id: eastleigh_run.id}).last.parkrunner).to eq('Alison MEARS')
        expect(Result.where('parkrunner': 'Alison MEARS').first.age_cat_position).to eq(13)
      end
    end
  end

  describe "It cleans unassociated runs out" do
    context "When there are runs that are NOT associated" do
      let(:run1) { create :run }
      let(:run2) { create :run,  run_identifier: 'Somewhere'}
      it "cleans out associated runs" do
        run1.reload
        run2.reload
        expect(run1).to be_valid
        expect(Run.all.count).to eq(2)
        UnusedRuns.perform
        expect(Run.all.count).to eq(0)
      end
    end
    context "When there are runs that are associated" do
      let(:run1) { create :run }
      let(:run2) { create :run,  run_identifier: 'run with milestone'}      
      let (:milestone1) { create :milestone, run_id: run1.id }    
      it "cleans out associated runs" do
        run1.reload; run2.reload; milestone1.reload; 
        expect(Run.all.count).to eq(2)
        UnusedRuns.perform
        expect(Run.all.count).to eq(1)
      end
    end
  end
end