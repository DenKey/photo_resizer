module Api::V1
  class UserEnrollmentController < BaseController
    include Api::Concerns::ApipieDefinitions

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
      param_group :errors_data
    end
    def create
      begin
        User.create!(enroll_params)

        render_json
      rescue Mongoid::Errors::Validations => e
        raise Api::MissingOrInvalidParametersError.new(e.document.errors.full_messages.join(", "))
      end
    end

    private

    def enroll_params
      params.require(:enroll).permit :email, :password
    end
  end
end
