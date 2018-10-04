require 'rails_helper'

describe Build do
  it { is_expected.to be_mongoid_document }

  it { is_expected.to have_field(:build_number).of_type(String) }
  it { is_expected.to have_field(:support_level).of_type(String) }

  it { is_expected.to validate_presence_of(:build_number) }
  it { is_expected.to validate_uniqueness_of(:build_number) }
  it { is_expected.to validate_presence_of(:support_level) }
  it { is_expected.to validate_inclusion_of(:support_level).to_allow(Build::SUPPORT_LEVELS) }

  it "described class is Build" do
    expect(described_class).to eq(Build)
  end
end
