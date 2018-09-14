module Api::V1
  class UserEnrollmentController < Api::BaseController
    skip_before_action :authenticate_user

    api :POST, "api/user_enrollment", "User enrollment"
    error :code => 400, :desc => "Enrollment parameters error"
    error :code => 500, :desc => "Internal server error"
    param :enroll, Hash, :desc => 'Enrollment data' do
      param :email, String, :desc => "Email for login", :required => true
      param :password, String, :desc => "Password for login. At least 6 symbols", :required => true
    end
    formats ['json']
    returns :code => 200, :desc => "a successful response" do
      property :data, NilClass, :desc => "Empty field"
      property :errors, Array, of: Hash, :desc => "Arrays wih errors hash" do
        property :code, String, :desc => "Error code"
        property :message, String, :desc => "Error message"
      end
    end
    def create
      begin
        User.create!(enroll_params)

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