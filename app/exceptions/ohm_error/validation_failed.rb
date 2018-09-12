module OhmError
  class ValidationFailed < StandardError
    def initialize(message: "Validation failed on attributes:", attributes: [])
      super("#{message} #{attributes.join('')}")
    end
  end
end
