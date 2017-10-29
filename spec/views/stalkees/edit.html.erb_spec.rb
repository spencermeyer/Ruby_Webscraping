require 'rails_helper'

RSpec.describe "stalkees/edit", type: :view do
  skip 'this view is not needed' do
    before(:each) do
      @stalkee = assign(:stalkee, Stalkee.create!(
        :parkrunner => "MyString"
      ))
    end

    it "renders the edit stalkee form" do
      render

      assert_select "form[action=?][method=?]", stalkee_path(@stalkee), "post" do

        assert_select "input#stalkee_parkrunner[name=?]", "stalkee[parkrunner]"
      end
    end
  end
end
