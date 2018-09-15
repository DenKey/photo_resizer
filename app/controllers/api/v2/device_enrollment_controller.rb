module Api::V2
  class DeviceEnrollmentController < BaseController
    include Api::V2::DeviceEnrollmentDoc

    before_action :set_device, only: [:create]

    def create
      render_json data: { token: @device.token }
    end

    private

    def set_device
      begin
        @device = Device.find_by(enroll_params)
      rescue Mongoid::Errors::DocumentNotFound
        create_device
      end
    end

    def create_device
      begin
        @device = Device.create!(enroll_params)
      rescue Mongoid::Errors::Validations => e
        raise Api::MissingOrInvalidParametersError.new(e.document.errors.full_messages.join(", "))
      end
    end

    def enroll_params
      params.require(:enroll).permit(:advertising_identifier, :imei, :meid)
    end
  end
end
