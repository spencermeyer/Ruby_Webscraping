require 'rails_helper'

RSpec.describe "visits/show", type: :view do
  before(:each) do
    @visit = assign(:visit, Visit.create!(
      :ip_address => "",
      :browser => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/MyText/)
  end
end
