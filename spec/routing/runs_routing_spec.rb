require "rails_helper"

RSpec.describe RunsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/runs").to route_to("runs#index")
    end

    it "routes to #new" do
      expect(:get => "/runs/new").to route_to("runs#new")
    end

    it "routes to #show" do
      expect(:get => "/runs/1").to route_to("runs#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/runs/1/edit").to route_to("runs#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/runs").to route_to("runs#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/runs/1").to route_to("runs#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/runs/1").to route_to("runs#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/runs/1").to route_to("runs#destroy", :id => "1")
    end

  end
end
