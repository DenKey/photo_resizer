module GeneratorTestData
  def random_string(length)
    chars = ('a'..'z').to_a + ('A'..'Z').to_a
    seed = chars[rand(chars.length)]
    Digest::SHA1.hexdigest(seed)[0,length]
  end

  # Use simple helpers instead of FactoryGirl
  def create_device
    Device.create(advertising_identifier: random_string(6),
                  imei: random_string(6),
                  meid: random_string(6))
  end

  def create_user
    User.create(email: random_string(5) + "@mail.com",
                password: random_string(5))
  end
end
