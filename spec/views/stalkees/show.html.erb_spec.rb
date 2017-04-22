require 'rails_helper'

RSpec.describe "stalkees/show", type: :view do
  before(:each) do
    @stalkee = assign(:stalkee, Stalkee.create!(
      :parkrunner => "Parkrunner"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Parkrunner/)
  end
end
