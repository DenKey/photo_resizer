class User
  include BCrypt
  include Mongoid::Document
  include Mongoid::Timestamps::Created

  field :email, type: String
  field :password_digest, type: String

  has_many :images, as: :imagable

  validates :email, presence: true, uniqueness: true
  validates_format_of  :email, :with => /\A[\+A-Z0-9\._%-]+@([A-Z0-9-]+\.)+[A-Z]{2,4}\z/i
  validates :password_digest, presence: true

  class << self
    def from_token_payload(payload)
      self.find_by(_id: payload["sub"]["$oid"])
    end
  end

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
end

