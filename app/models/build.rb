class Build < Ohm::Model
  include Ohm::Validations
  include OhmExtends

  # Support levels available for application
  # i was skip way for creating Build,
  # it may work from console or directly from DB
  SUPPORT_LEVELS = %w{supported unsupported deprecated}

  attribute :build_number
  attribute :support_level

  unique :build_number

  index :build_number

  protected

  def validate
    assert_present(:build_number)
    assert_present(:support_level)
    assert_member(:support_level, SUPPORT_LEVELS)
  end
end
