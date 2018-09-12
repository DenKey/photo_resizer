PhotoResizer::Application.config.secret_key_base =
  if Rails.env.development? or Rails.env.test?
    '2954812abae47760b1439ae0d92f621577a886e753a9c28c1b16fd8dea7bd14cdab7e8ad3be0b25a2a46ee55e597f16ae6e4bc2ae1503b82923b39d48ad3138a'
  else
    ENV['SECRET_TOKEN']
  end
