require 'rails_helper'

RSpec.describe "users/index", type: :view do
  skip 'TODO get this test working' do
    before(:each) do
      assign(:users, [
        User.create!(
          :name => "Name",
          :email => "Email@email.com",
          :password => "password"
        ),
        User.create!(
          :name => "Name",
          :email => "Email"
        )
      ])
    end

    it "renders a list of users" do
      render
      assert_select "tr>td", :text => "Name".to_s, :count => 2
      assert_select "tr>td", :text => "Email".to_s, :count => 2
    end
  end
end
