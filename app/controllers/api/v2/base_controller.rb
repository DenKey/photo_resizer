module Api::V2
  class BaseController < Api::BaseController
    resource_description do
      api_version "2.0"
    end
  end
end
