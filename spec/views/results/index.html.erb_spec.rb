require 'rails_helper'

RSpec.describe "results/index", type: :view do
  before(:each) do
    assign(:results, [
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
        :total => 3
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
        :total => 3
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
