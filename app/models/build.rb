class Build
  include Mongoid::Document

  # Support levels available for application
  # i was skip way for creating Build,
  # it may work from console or directly from DB
  SUPPORT_LEVELS = %w{supported unsupported deprecated}

  field :build_number, type: String
  field :support_level, type: String

  validates :build_number, presence: true, uniqueness: true
  validates :support_level, presence: true, inclusion: SUPPORT_LEVELS
end
