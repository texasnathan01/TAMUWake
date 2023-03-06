require "rails_helper"

RSpec.describe SetRolesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/set_roles").to route_to("set_roles#index")
    end

    it "routes to #new" do
      expect(get: "/set_roles/new").to route_to("set_roles#new")
    end

    it "routes to #show" do
      expect(get: "/set_roles/1").to route_to("set_roles#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/set_roles/1/edit").to route_to("set_roles#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/set_roles").to route_to("set_roles#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/set_roles/1").to route_to("set_roles#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/set_roles/1").to route_to("set_roles#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/set_roles/1").to route_to("set_roles#destroy", id: "1")
    end
  end
end
