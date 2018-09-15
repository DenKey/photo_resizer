module Api
  class ImageProcessingFailed < StandardError
    def code
      'IMAGE_PROCESSSING_FAILED'
    end

    def public_message
      Settings.api.errors.image_processing_failed
    end
  end
end
