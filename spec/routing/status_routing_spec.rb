require 'rails_helper'

describe 'routes for Api::Status' do
  %W{static production staging development}.each do |action|
    it "routes GET /status/#{action} to the status controller action #{action} correctly" do
      expect(get("/status/#{action}")).to route_to(controller: 'status', action: action)
    end
  end
end