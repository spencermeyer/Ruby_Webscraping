require 'rails_helper'

RSpec.describe "visits/edit", type: :view do
  before(:each) do
    @visit = assign(:visit, Visit.create!(
      :ip_address => "",
      :browser => "MyText"
    ))
  end

  it "renders the edit visit form" do
    render

    assert_select "form[action=?][method=?]", visit_path(@visit), "post" do

      assert_select "input#visit_ip_address[name=?]", "visit[ip_address]"

      assert_select "textarea#visit_browser[name=?]", "visit[browser]"
    end
  end
end
