require 'rails_helper'

describe "routes for Api::V2::Images", :routes_api_v2 do
  it "routes GET /api/images to the images controller action index correctly" do
    expect(get("/api/images")).
        to route_to(controller: "api/v2/images", action: "index")
  end

  it "routes POST /api/images to the images controller action create correctly" do
    expect(post("/api/images")).
        to route_to(controller: "api/v2/images", action: "create")
  end

  it "routes GET /api/images/:id to the images controller action show correctly" do
    expect(get("/api/images/1")).
        to route_to(controller: "api/v2/images", action: "show", id: "1")
  end

  it "routes PUT /api/images/:id to the images controller action update correctly" do
    expect(put("/api/images/1")).
        to route_to(controller: "api/v2/images", action: "update", id: "1")
  end
end