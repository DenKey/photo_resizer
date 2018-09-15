module Api::V2
  class BaseController < Api::BaseController
    skip_before_action :authenticate_user

    resource_description do
      api_version "2.0"
    end
  end
end
