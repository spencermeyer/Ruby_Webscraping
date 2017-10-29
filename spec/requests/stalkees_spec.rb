require 'rails_helper'

RSpec.describe "Stalkees", type: :request do
  skip 'no request spec for stalkees yet' do
    describe "GET /stalkees" do
      it "works! (now write some real specs)" do
        get stalkees_path
        expect(response).to have_http_status(200)
      end
    end
  end
end
