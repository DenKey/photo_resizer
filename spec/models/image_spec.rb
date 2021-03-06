require 'rails_helper'

describe Image do
  it { is_expected.to be_mongoid_document }

  it { is_expected.to have_field(:filename).of_type(String) }
  it { is_expected.to have_field(:width).of_type(String) }
  it { is_expected.to have_field(:height).of_type(String) }
  it { is_expected.to have_field(:width_param).of_type(String) }
  it { is_expected.to have_field(:height_param).of_type(String) }

  it { is_expected.to belong_to(:imagable) }

  it "described class is Image" do
    expect(described_class).to eq(Image)
  end
end
