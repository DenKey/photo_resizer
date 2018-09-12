class ApplicationController < ActionController::API
  include Knock::Authenticable
  skip_before_filter :verify_authenticity_token

  before_action :authenticate_user
end
