require 'rails_helper'

describe 'routes for Api:V1::Users', :routes_api_v1 do
  it "routes POST /api/user_token to the user_token controller action create correctly" do
    expect(post("/api/user_token")).
        to route_to(controller: "api/v1/user_token", action: "create")
  end

  it "routes POST /api/user_enrollment to the user_token controller action create correctly" do
    expect(post("/api/user_enrollment")).
        to route_to(controller: "api/v1/user_enrollment", action: "create")
  end
end