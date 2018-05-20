 require 'rails_helper'

RSpec.describe Task, type: :model do

	context "Model validation" do
	  it { is_expected.to validate_presence_of(:name) }
	  it { is_expected.to validate_presence_of(:owner_id) }
	  it { is_expected.to validate_presence_of(:description) }
	  it { is_expected.to validate_presence_of(:start_date) }
	  it { is_expected.to validate_presence_of(:due_date) }
	  it { is_expected.to validate_presence_of(:status) }
	  it { is_expected.to define_enum_for(:status).with(%w(new_task in_progress done)) }
	end

  context "Model association" do
	  it { is_expected.to belong_to :project }
	  it { is_expected.to belong_to :owner }
	  it { should have_many(:user_tasks).dependent(:destroy) }
	  it { should have_many(:assigned_users).through(:user_tasks) }
  end
end
