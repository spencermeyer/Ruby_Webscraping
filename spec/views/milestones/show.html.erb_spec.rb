require 'rails_helper'

RSpec.describe "milestones/show", type: :view do
  skip 'OK I should add some tests here !!!!!' do
    before(:each) do
      @milestone = assign(:milestone, Milestone.create!(
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
      ))
    end

    it "renders attributes in <p>" do
      render
      expect(rendered).to match(/2/)
      expect(rendered).to match(/Parkrunner/)
      expect(rendered).to match(/Time/)
      expect(rendered).to match(/Age Cat/)
      expect(rendered).to match(/Age Grade/)
      expect(rendered).to match(/Gender/)
      expect(rendered).to match(/Gender Pos/)
      expect(rendered).to match(/Club/)
      expect(rendered).to match(/Note/)
      expect(rendered).to match(/3/)
      expect(rendered).to match(/4/)
      expect(rendered).to match(/5/)
      expect(rendered).to match(/6/)
      expect(rendered).to match(/Athlete Number/)
      expect(rendered).to match(/Integer/)
    end
  end
end
