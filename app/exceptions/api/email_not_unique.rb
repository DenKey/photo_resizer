module Api
  class EmailNotUnique < StandardError
    def code
      'EMAIL_NOT_UNIQUE'
    end

    def public_message
      Settings.api.errors.email_not_unique
    end
  end
end
