module Api
  class BaseController < ApplicationController
    around_action :run_action

    STATUS_PARAMETER_ERROR = 400
    STATUS_AUTHENTICATION_ERROR = 401
    STATUS_BAD_REQUEST_ERROR = 403
    STATUS_MISSING_RESOURCE_ERROR = 404
    STATUS_USER_ENROLLMENT_FAILED_ERROR = 422
    STATUS_SERVER_ERROR = 500


    def render_json(data: nil, errors: [], status: 200)
      render json: {
        data: data,
        errors: errors
      }, status: status
    end

    private

    def error(e, status:, public_message: Settings.api.errors.generic)
      public_message = e.respond_to?(:public_message) ? e.public_message : public_message

      error_hash = {
        code: e.try(:code) || "UNKNOWN_ERROR",
        message: e.message,
        public_message: public_message
      }

      render_json(errors: [error_hash], status: status)
    end

    def run_action
      begin
        yield
      rescue => e
        case e
          when Api::RecordNotFound
            error(e, status: STATUS_MISSING_RESOURCE_ERROR)
          when Api::MissingOrInvalidParametersError
            error(e, status: STATUS_PARAMETER_ERROR)
          else
            error(e, status: STATUS_SERVER_ERROR)
        end
      end
    end
  end
end
