module Api::V1
  class UserEnrollmentController < BaseController
    include Api::V1::UserEnrollmentDoc

    skip_before_action :authenticate_user

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
