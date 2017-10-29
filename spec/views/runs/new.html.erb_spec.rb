require 'rails_helper'

RSpec.describe "runs/new", type: :view do
  skip 'this view is not used' do
    before(:each) do
      assign(:run, Run.new(
        :run_identifier => "MyString"
      ))
    end

    it "renders new run form" do
      render

      assert_select "form[action=?][method=?]", runs_path, "post" do

        assert_select "input#run_run_identifier[name=?]", "run[run_identifier]"
      end
    end
  end
end
