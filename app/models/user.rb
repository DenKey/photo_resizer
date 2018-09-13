class User < Ohm::Model
  include BCrypt
  include Ohm::Validations
  include OhmExtends

  attribute :email
  attribute :password_digest

  unique :email

  index :email

  class << self
    def from_token_payload(payload)
      self[payload['sub']]
    end
  end

  def password
    @password ||= Password.new(password_digest)
  end

  def password=(new_password)
    return if password_invalid?(new_password)
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

  protected

  def validate
    assert_present(:email)
    assert_present(:password_digest)
    assert_email(:email)
  end

  def validation_failed
    raise OhmError::ValidationFailed.new(attributes: errors.keys)
  end

  def password_invalid?(password)
    password.blank? || password.size < 6
  end
end

