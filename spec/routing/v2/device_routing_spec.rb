require 'rails_helper'

describe "routes for Api::V2::Images", :routes_api_v2 do
  it "routes POST /api/device_enrollment to the device_enrollment controller action create correctly" do
    expect(post("/api/device_enrollment")).
        to route_to(controller: "api/v2/device_enrollment", action: "create")
  end
end