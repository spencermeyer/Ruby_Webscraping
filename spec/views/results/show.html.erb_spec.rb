require 'rails_helper'

RSpec.describe "results/show", type: :view do
  before(:each) do
    @result = assign(:result, Result.create!(
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
  end
end
