module Api::V1
  class BaseController < Api::BaseController
    resource_description do
      api_version "1.0"
    end
  end
end
