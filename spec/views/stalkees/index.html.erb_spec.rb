require 'rails_helper'

RSpec.describe "stalkees/index", type: :view do
  skip 'this test is not needed' do
    before(:each) do
      assign(:stalkees, [
        Stalkee.create!(
          :parkrunner => "Parkrunner"
        ),
        Stalkee.create!(
          :parkrunner => "Parkrunner"
        )
      ])
    end

    it "renders a list of stalkees" do
      render
      assert_select "tr>td", :text => "Parkrunner".to_s, :count => 2
    end
  end
end
