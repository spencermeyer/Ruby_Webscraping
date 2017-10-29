require 'rails_helper'

RSpec.describe "milestones/index", type: :view do
  skip 'SHOULD PROBABLY DO A TEST FOR THIS VIEW AT SOME STAGE' do
    before(:each) do
        assign(:milestones, [
          Milestone.create!(
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
            :run_id => 4,
            :age_grade_position => 5,
            :age_cat_position => 6,
            :athlete_number => "Athlete Number",
            :integer => "Integer"
          ),
          Milestone.create!(
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
            :run_id => 4,
            :age_grade_position => 5,
            :age_cat_position => 6,
            :athlete_number => "Athlete Number",
            :integer => "Integer"
          )
        ])
      end

      it "renders a list of milestones" do
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
        assert_select "tr>td", :text => 4.to_s, :count => 2
        assert_select "tr>td", :text => 5.to_s, :count => 2
        assert_select "tr>td", :text => 6.to_s, :count => 2
        assert_select "tr>td", :text => "Athlete Number".to_s, :count => 2
        assert_select "tr>td", :text => "Integer".to_s, :count => 2
      end
  end
end