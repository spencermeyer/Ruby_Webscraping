require 'rails_helper'

RSpec.describe "visits/new", type: :view do
  skip 'this view is not needed' do
    before(:each) do
      assign(:visit, Visit.new(
        :ip_address => "",
        :browser => "MyText"
      ))
    end

    it "renders new visit form" do
      render

      assert_select "form[action=?][method=?]", visits_path, "post" do

        assert_select "input#visit_ip_address[name=?]", "visit[ip_address]"

        assert_select "textarea#visit_browser[name=?]", "visit[browser]"
      end
    end
  end
end
