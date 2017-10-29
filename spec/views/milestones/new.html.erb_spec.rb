require 'rails_helper'

RSpec.describe "milestones/new", type: :view do
  skip 'this view is not used' do
    before(:each) do
      assign(:milestone, Milestone.new(
        :pos => 1,
        :parkrunner => "MyString",
        :time => "MyString",
        :age_cat => "MyString",
        :age_grade => "MyString",
        :gender => "MyString",
        :gender_pos => "MyString",
        :club => "MyString",
        :note => "MyString",
        :total => 1,
        :run_id => 1,
        :age_grade_position => 1,
        :age_cat_position => 1,
        :athlete_number => "MyString",
        :integer => "MyString"
      ))
    end

    it "renders new milestone form" do
      render

      assert_select "form[action=?][method=?]", milestones_path, "post" do

        assert_select "input#milestone_pos[name=?]", "milestone[pos]"

        assert_select "input#milestone_parkrunner[name=?]", "milestone[parkrunner]"

        assert_select "input#milestone_time[name=?]", "milestone[time]"

        assert_select "input#milestone_age_cat[name=?]", "milestone[age_cat]"

        assert_select "input#milestone_age_grade[name=?]", "milestone[age_grade]"

        assert_select "input#milestone_gender[name=?]", "milestone[gender]"

        assert_select "input#milestone_gender_pos[name=?]", "milestone[gender_pos]"

        assert_select "input#milestone_club[name=?]", "milestone[club]"

        assert_select "input#milestone_note[name=?]", "milestone[note]"

        assert_select "input#milestone_total[name=?]", "milestone[total]"

        assert_select "input#milestone_run_id[name=?]", "milestone[run_id]"

        assert_select "input#milestone_age_grade_position[name=?]", "milestone[age_grade_position]"

        assert_select "input#milestone_age_cat_position[name=?]", "milestone[age_cat_position]"

        assert_select "input#milestone_athlete_number[name=?]", "milestone[athlete_number]"

        assert_select "input#milestone_integer[name=?]", "milestone[integer]"
      end
    end
  end
end
