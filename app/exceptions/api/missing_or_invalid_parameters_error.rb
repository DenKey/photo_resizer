module Api
  class MissingOrInvalidParametersError < StandardError
    def code
      'PARAMETERS_ERROR'
    end

    def public_message
      Settings.api.errors.parameters_error
    end
  end
end
