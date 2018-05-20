require 'rails_helper'

RSpec.describe User, type: :model do

	context "Model validation" do
	  it { is_expected.to validate_presence_of(:full_name) }
	  it { is_expected.to validate_presence_of(:email) }
	  it { should allow_value('user@example.com').for(:email ) }
	  it { should_not allow_value('userexample.com').for(:email ) }
	  it { is_expected.to validate_presence_of(:role) }
	  it { is_expected.to define_enum_for(:role).with(%w(developer admin)) }
	end

  context "Model association" do
  	  it { should have_many(:projects).dependent(:destroy) }
	  it { should have_many(:tasks).dependent(:destroy) }
	  it { should have_many(:teams).dependent(:destroy) }
	  it { should have_many(:collaboration_projects).through(:teams) }
	  it { should have_many(:user_tasks).dependent(:destroy) }
	  it { should have_many(:assigned_tasks).through(:user_tasks) }
  end
end
