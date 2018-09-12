module Physical
  class User < Ohm::Model
    include BCrypt
    include Ohm::Validations

    attribute :email
    attribute :password_digest

    unique :email

    index :email

    def password
      @password ||= Password.new(password_digest)
    end

    def password=(new_password)
      @password = Password.create(new_password)
      self.password_digest = @password
    end

    def authenticate(unencrypted_password)
      password == unencrypted_password
    end

    def save!
      if self.save
        self
      else
        validation_failed
      end
    end

    def create!
      if self.create
        self
      else
        validation_failed
      end
    end

    def self.find_by(attrs)
      find(attrs).first
    end

    protected

    def validate
      assert_present(:email)
      assert_email(:email)
    end

    def validation_failed
      raise OhmError::ValidationFailed.new(attributes: errors.keys)
    end
  end
end
