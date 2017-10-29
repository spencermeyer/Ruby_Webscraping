require 'rails_helper'
# need to sort devise !
RSpec.describe "results/index", type: :view do
  skip 'SHOULD SORT OUT DEVISE AND GET THIS TEST WORKING!' do
      before(:each) do
        puts 'NEED TO SORT DEVISE'
        assign(:results, [
          run_spec_run=Run.create!(
            run_identifier: 'rspec_ville'
            ),
          Result.create!(
            :pos => 2,
            :parkrunner => "Parkrunner",
            :time => "Time",
            :age_cat => "Age Cat",
            :age_grade => "Age Grade",
            :gender => "Gender",
            :gender_pos => "Gender Pos",
            :club => "Club",
            :note => "Note",
            :total => 3,
            :run_id => run_spec_run.id
          ),
          Result.create!(
            :pos => 2,
            :parkrunner => "Parkrunner",
            :time => "Time",
            :age_cat => "Age Cat",
            :age_grade => "Age Grade",
            :gender => "Gender",
            :gender_pos => "Gender Pos",
            :club => "Club",
            :note => "Note",
            :total => 3,
            :run_id => run_spec_run.id        
          )
        ])
      end

      it "renders a list of results" do
        render
        assert_select "tr>td", :text => 2.to_s, :count => 2
        assert_select "tr>td", :text => "Parkrunner".to_s, :count => 2
        assert_select "tr>td", :text => "Time".to_s, :count => 2
        assert_select "tr>td", :text => "Age Cat".to_s, :count => 2
        assert_select "tr>td", :text => "Age Grade".to_s, :count => 2
        assert_select "tr>td", :text => "Gender".to_s, :count => 2
        assert_select "tr>td", :text => "Gender Pos".to_s, :count => 2
        assert_select "tr>td", :text => "Club".to_s, :count => 2
        assert_select "tr>td", :text => "Note".to_s, :count => 2
        assert_select "tr>td", :text => 3.to_s, :count => 2
      end
    end
end
