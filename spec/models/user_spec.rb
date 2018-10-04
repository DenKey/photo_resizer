require 'rails_helper'

describe User do
  it { is_expected.to be_mongoid_document }

  it { is_expected.to have_field(:email).of_type(String) }
  it { is_expected.to have_field(:password_digest).of_type(String) }

  it { is_expected.to have_timestamps.for(:creating) }

  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_uniqueness_of(:email) }
  it { is_expected.to validate_presence_of(:password_digest) }

  it { is_expected.to validate_format_of(:email).to_allow("valid@mail.com").not_to_allow("invalid") }

  it "password_digest was generated", :generator_test_data do
    user = create_user

    expect(user.password_digest).not_to be_nil
  end

  it "described class is User" do
    expect(described_class).to eq(User)
  end
end
