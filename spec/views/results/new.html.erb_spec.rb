require 'rails_helper'

RSpec.describe "results/new", type: :view do
  skip 'this view is not being used' do
    before(:each) do
      assign(:result, Result.new(
        :pos => 1,
        :parkrunner => "MyString",
        :time => "MyString",
        :age_cat => "MyString",
        :age_grade => "MyString",
        :gender => "MyString",
        :gender_pos => "MyString",
        :club => "MyString",
        :note => "MyString",
        :total => 1
      ))
    end

    it "renders new result form" do
      render

      assert_select "form[action=?][method=?]", results_path, "post" do

        assert_select "input#result_pos[name=?]", "result[pos]"

        assert_select "input#result_parkrunner[name=?]", "result[parkrunner]"

        assert_select "input#result_time[name=?]", "result[time]"

        assert_select "input#result_age_cat[name=?]", "result[age_cat]"

        assert_select "input#result_age_grade[name=?]", "result[age_grade]"

        assert_select "input#result_gender[name=?]", "result[gender]"

        assert_select "input#result_gender_pos[name=?]", "result[gender_pos]"

        assert_select "input#result_club[name=?]", "result[club]"

        assert_select "input#result_note[name=?]", "result[note]"

        assert_select "input#result_total[name=?]", "result[total]"
      end
    end
  end
end
