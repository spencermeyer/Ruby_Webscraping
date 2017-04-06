require 'rails_helper'

RSpec.describe "visits/index", type: :view do
  before(:each) do
    assign(:visits, [
      Visit.create!(
        :ip_address => "",
        :browser => "MyText"
      ),
      Visit.create!(
        :ip_address => "",
        :browser => "MyText"
      )
    ])
  end

  it "renders a list of visits" do
    render
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
