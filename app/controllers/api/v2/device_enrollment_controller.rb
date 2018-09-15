module Api::V2
  class DeviceEnrollmentController < BaseController
    include Api::Concerns::ApipieDefinitions

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
      param_group :errors_data
    end
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
