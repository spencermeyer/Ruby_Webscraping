require 'rails_helper'

RSpec.describe "Milestones", type: :request do
  skip 'no milestones request specs yet' do
    describe "GET /milestones" do
      it "works! (now write some real specs)" do
        get milestones_path
        expect(response).to have_http_status(200)
      end
    end
  end
end
