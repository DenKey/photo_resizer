class Device
  include Mongoid::Document
  include Mongoid::Timestamps::Created

  field :advertising_identifier, type: String
  field :imei, type: String
  field :meid, type: String
  field :token, type: String

  has_many :images, as: :imagable

  validates :advertising_identifier, presence: true, uniqueness: true
  validates :token, presence: true, uniqueness: true

  after_initialize :set_token

  private

  def set_token
    self.token = generate_token
  end

  def generate_token
    Digest::SHA256.hexdigest(advertising_identifier.to_s + imei.to_s + meid.to_s)
  end
end
