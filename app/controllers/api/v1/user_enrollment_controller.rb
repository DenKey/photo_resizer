module Api::V1
  class UserEnrollmentController < Api::BaseController
    skip_before_action :authenticate_user

    api :POST, "api/v1/api/user_enrollment", "User enrollment"
    error :code => 400, :desc => "Enrollment parameters error"
    error :code => 500, :desc => "Internal server error"
    param :enroll, Hash, :desc => 'Enrollment data' do
      param :email, String, :desc => "Email for login", :required => true
      param :password, String, :desc => "Password for login. At least 6 symbols", :required => true
    end
    formats ['json']
    returns :code => 200, :desc => "a successful response"
    def create
      begin
        User.new(enroll_params).save!

        render_json
      rescue OhmError::ValidationFailed
        raise Api::MissingOrInvalidParametersError
      rescue Ohm::UniqueIndexViolation
        raise Api::EmailNotUnique
      end
    end

    private

    def enroll_params
      params.require(:enroll).permit :email, :password
    end
  end
end
