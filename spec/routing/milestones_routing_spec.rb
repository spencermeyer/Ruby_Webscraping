require "rails_helper"

RSpec.describe MilestonesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/milestones").to route_to("milestones#index")
    end

    it "routes to #new" do
      expect(:get => "/milestones/new").to route_to("milestones#new")
    end

    it "routes to #show" do
      expect(:get => "/milestones/1").to route_to("milestones#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/milestones/1/edit").to route_to("milestones#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/milestones").to route_to("milestones#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/milestones/1").to route_to("milestones#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/milestones/1").to route_to("milestones#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/milestones/1").to route_to("milestones#destroy", :id => "1")
    end

  end
end
