require 'rails_helper'

RSpec.describe "runs/show", type: :view do
  before(:each) do
    @run = assign(:run, Run.create!(
      :run_identifier => "Run Identifier"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Run Identifier/)
  end
end
