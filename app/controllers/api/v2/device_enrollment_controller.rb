module Api::V2
  class DeviceEnrollmentController < Api::BaseController
    skip_before_action :authenticate_user
    before_action :set_device, only: [:create]

    api :POST, "api/device_enrollment", "Device enrollment"
    error :code => 400, :desc => "Enrollment parameters error"
    error :code => 500, :desc => "Internal server error"
    param :enroll, Hash, :desc => "Enrollment data" do
      param :advertising_identifier, String, required: true
      param :imei, String, required: true
      param :meid, String, required: true
    end
    formats ['json']
    returns :code => 200, :desc => "a successful response" do
      property :data, Hash, :desc => "Hash with data" do
        property :token, String, :desc => "String that provides identification of user device"
      end
      property :errors, Array, of: Hash, :desc => "Arrays wih errors hash" do
        property :code, String, :desc => "Error code"
        property :message, String, :desc => "Error message"
      end
    end
    def create
      render_json data: { token: @device.token }
    end

    private

    def set_device
      Rails.logger.info enroll_params
      begin
        @device = Device.find_by(enroll_params) || Device.create!(enroll_params)
      rescue OhmError::ValidationFailed
        raise Api::MissingOrInvalidParametersError
      rescue Ohm::UniqueIndexViolation
        raise Api::AdIdentNotUnique
      end
    end

    def enroll_params
      params.
        require(:enroll).
        permit(:advertising_identifier, :imei, :meid).
        to_hash.
        symbolize_keys
    end
  end
end
