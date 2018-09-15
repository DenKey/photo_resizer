module Api::V2
  module DeviceEnrollmentDoc
    extend Apipie::DSL::Concern
    include Api::ParamGroupsDocExtend

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
      # stub
    end
  end
end
