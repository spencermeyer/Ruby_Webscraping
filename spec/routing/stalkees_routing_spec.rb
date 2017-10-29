require "rails_helper"

RSpec.describe StalkeesController, type: :routing do
  skip 'there are no relevant stalkees routing tests' do
    describe "routing" do

      it "routes to #index" do
        expect(:get => "/stalkees").to route_to("stalkees#index")
      end

      it "routes to #new" do
        expect(:get => "/stalkees/new").to route_to("stalkees#new")
      end

      it "routes to #show" do
        expect(:get => "/stalkees/1").to route_to("stalkees#show", :id => "1")
      end

      it "routes to #edit" do
        expect(:get => "/stalkees/1/edit").to route_to("stalkees#edit", :id => "1")
      end

      it "routes to #create" do
        expect(:post => "/stalkees").to route_to("stalkees#create")
      end

      it "routes to #update via PUT" do
        expect(:put => "/stalkees/1").to route_to("stalkees#update", :id => "1")
      end

      it "routes to #update via PATCH" do
        expect(:patch => "/stalkees/1").to route_to("stalkees#update", :id => "1")
      end

      it "routes to #destroy" do
        expect(:delete => "/stalkees/1").to route_to("stalkees#destroy", :id => "1")
      end

    end
  end
end
