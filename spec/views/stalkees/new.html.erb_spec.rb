require 'rails_helper'

RSpec.describe "stalkees/new", type: :view do
  before(:each) do
    assign(:stalkee, Stalkee.new(
      :parkrunner => "MyString"
    ))
  end

  it "renders new stalkee form" do
    render

    assert_select "form[action=?][method=?]", stalkees_path, "post" do

      assert_select "input#stalkee_parkrunner[name=?]", "stalkee[parkrunner]"
    end
  end
end
