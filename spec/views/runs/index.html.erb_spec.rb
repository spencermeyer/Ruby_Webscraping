require 'rails_helper'

RSpec.describe "runs/index", type: :view do
  before(:each) do
    assign(:runs, [
      Run.create!(
        :run_identifier => "Run Identifier"
      ),
      Run.create!(
        :run_identifier => "Run Identifier"
      )
    ])
  end

  it "renders a list of runs" do
    render
    assert_select "tr>td", :text => "Run Identifier".to_s, :count => 2
  end
end
