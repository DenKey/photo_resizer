require 'rails_helper'

describe 'routes for Api:V1::Users', :routes_api_v1 do
  it "routes GET /api/build/:build_number to the build controller action show correctly" do
    expect(get("/api/build/1")).
        to route_to(controller: "api/v1/build", action: "show", build_number: "1")
  end
end