module Api::V1
  class UserTokenController < Knock::AuthTokenController
    include Api::V1::UserTokenDoc

    skip_before_action :verify_authenticity_token
  end
end
