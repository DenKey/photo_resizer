module Api
  class DeviceNotFound < StandardError
    def code
      'DEVICE_NOT_FOUND'
    end

    def public_message
      Settings.api.errors.device_not_found
    end
  end
end
