require 'rails_helper'

RSpec.describe "runs/edit", type: :view do
  skip 'this view is not used' do
    before(:each) do
      @run = assign(:run, Run.create!(
        :run_identifier => "MyString"
      ))
    end

    it "renders the edit run form" do
      render

        assert_select "form[action=?][method=?]", run_path(@run), "post" do

        assert_select "input#run_run_identifier[name=?]", "run[run_identifier]"
      end
    end
  end
end
