require 'rails_helper'

RSpec.describe "Runs", type: :request do
  skip 'no request spec for runs yet' do
    describe "GET /runs" do
      it "works! (now write some real specs)" do
        get runs_path
        expect(response).to have_http_status(200)
      end
    end
  end
end
