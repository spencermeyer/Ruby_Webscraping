require 'rails_helper'
require 'rails_helper'
include ScrapesHelper
require "#{Rails.root}/lib/scrapes/browserchoice"

RSpec.describe LineProcessor, type: :model do
  VCR.configure do |config|
    config.cassette_library_dir = "spec/fixtures/vcr_cassettes"
    config.hook_into :webmock
    #config.debug_logger= File.open('vcr_debug.md', 'w')
  end

  context 'it processes one set of real results' do
    it 'Processes the results for one url successfully' do
      VCR.use_cassette('scrape', record: :none) do  #record: :new_episodes :all :none
        described_class.perform( {'args_hash' => {'slink' => "http://localhost:4567/eastleigh/results/weeklyresults/?runSeqNumber=347", 'browser' => 'Linux Firefox'}})

        expect(Run.first.run_identifier).to eq('eastleigh')
        expect(Result.count).to eq(239)
        expect(Milestone.count).to eq(4)

        eastleigh_run=Run.where('run_identifier':'eastleigh').first

        expect(Result.where({'age_cat':'VW50-54', 'club':'Eastleigh RC', run_id: eastleigh_run.id}).order(:pos).last.parkrunner).to eq('Alison MEARS')
        expect(Result.where('parkrunner': 'Alison MEARS').first.age_cat_position).to eq(13)
        expect(Result.where('parkrunner': 'Alison MEARS').first.age_grade_position).to eq(216)
        expect(Result.where('parkrunner': 'Claire DEACON').first.age_cat_position).to eq(1)
        expect(Result.where('parkrunner': 'Claire DEACON').first.age_grade_position).to eq(18)
        expect(Result.where('parkrunner': 'Andrew PAYNE').first.age_cat_position).to eq(19)
        expect(Result.where('parkrunner': 'Andrew PAYNE').first.age_grade_position).to eq(149)
        expect(Result.where(run_id: eastleigh_run.id, age_cat: 'VW50-54').count).to eq(13)
        expect(Result.where(run_id: eastleigh_run.id, age_cat: 'VW50-54', age_cat_position: 1).first.parkrunner).to eq("Karen BOLTON")
      end
    end
  end
end
