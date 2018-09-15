module Api::V1
  class UserTokenController < Knock::AuthTokenController
    skip_before_action :verify_authenticity_token

    api :POST, "api/user_token", "Get JWT token for user login"
    error :code => 400, :desc => "Enrollment parameters error"
    error :code => 500, :desc => "Internal server error"
    param :auth, Hash, :desc => "Enrollment params", :required => true do
      param :email, String, required: true
      param :password, String, required: true
    end
    formats ['json']
    returns :code => 200, :desc => "a successful response" do
      property :jwt, Hash, :desc => "JWT for sing in"
    end
    def create
      super()
    end
  end
end
