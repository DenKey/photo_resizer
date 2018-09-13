class Device < Ohm::Model
  include Ohm::Validations
  include OhmExtends

  attribute :advertising_identifier
  attribute :imei
  attribute :meid
  attribute :token

  unique :advertising_identifier

  index :advertising_identifier
  index :imei
  index :meid

  def save!
   self.token = get_digest
    if self.save
      self
    else
      validation_failed
    end
  end

  protected

  def validate
    assert_present(:advertising_identifier)
    assert_present(:imei)
    assert_present(:meid)
    assert_present(:token)
  end

  def validation_failed
    raise OhmError::ValidationFailed.new(attributes: errors.keys)
  end

  def get_digest
    Digest::SHA256.hexdigest(advertising_identifier.to_s + imei.to_s + meid.to_s)
  end
end
