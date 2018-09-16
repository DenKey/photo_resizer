Apipie.configure do |config|
  config.app_name                = "PhotoResizer"
  config.copyright               = "&copy; 2018 Denys Kriukov"
  config.api_base_url            = "/api"
  config.doc_base_url            = "/apipie"
  config.translate               = false
  config.show_all_examples       = true
  config.reload_controllers      = Rails.env.development?
  # where is your API defined?
  config.api_controllers_matcher = "#{Rails.root}/app/controllers/**/*.rb"
  config.authenticate = Proc.new do
    authenticate_or_request_with_http_basic do |username, password|
      username == "api_developer" && password == "someofus123"
    end
  end
  config.app_info = <<-DOC
    Mobile app that allows a user to resize uploaded photos
  DOC
  config.app_info["1.0"] = <<-DOC
    Each request must contains header key 'Accept' with value 'version=1'.

    For authorization header key 'Authorzation' must contains 'Bearer: USER_TOKEN'.
    USER_TOKEN user get by /api/user_token after enrollment on /api/user_enrollment
  DOC
  config.app_info["1.0"] = <<-DOC
    Each request must contains header key 'Accept' with value 'version=2'.

    For authorization header key 'Authorzation' must contains device token from
    /api/device_enrollment
  DOC
end
