require 'rails_helper'

RSpec.describe Project, type: :model do

  context "Model validation" do
	  it { is_expected.to validate_presence_of(:name) }
	  it { should validate_length_of(:name).is_at_least(2).is_at_most(50) }
	  it { is_expected.to validate_presence_of(:owner_id) }
	  it { is_expected.to validate_presence_of(:description) }
	  it { is_expected.to validate_presence_of(:start_date) }
	  it { is_expected.to validate_presence_of(:due_date) }
	  it { is_expected.to validate_presence_of(:status) }
	  it { is_expected.to define_enum_for(:status).with(%w(active complete)) }
  end

  context "Model association" do
	  it { is_expected.to belong_to :owner }
	  it { should have_many(:tasks).dependent(:destroy) }
	  it { should have_many(:teams).dependent(:destroy) }
	  it { should have_many(:collaborators).through(:teams) }
  end

end

