require 'rails_helper'

describe Device do
  it { is_expected.to be_mongoid_document }

  it { is_expected.to have_field(:advertising_identifier).of_type(String) }
  it { is_expected.to have_field(:imei).of_type(String) }
  it { is_expected.to have_field(:meid).of_type(String) }
  it { is_expected.to have_field(:token).of_type(String) }

  it { is_expected.to validate_presence_of(:advertising_identifier) }
  it { is_expected.to validate_uniqueness_of(:advertising_identifier) }
  it { is_expected.to validate_presence_of(:token) }
  it { is_expected.to validate_uniqueness_of(:token) }

  it { is_expected.to have_many(:images) }

  it "token was generated", :generator_test_data do
    device = create_device

    expect(device.token).not_to be_nil
  end

  it "described class is Device" do
    expect(described_class).to eq(Device)
  end
end
