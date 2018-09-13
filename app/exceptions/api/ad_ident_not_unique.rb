module Api
  class AdIdentNotUnique < StandardError
    def code
      'ADVERTISING_IDENTIFIER_NOT_UNIQUE'
    end

    def public_message
      Settings.api.errors.ad_ident_not_unique
    end
  end
end
