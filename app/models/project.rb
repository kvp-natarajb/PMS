class Project < ApplicationRecord

	enum status: [:active, :complete]

	belongs_to :owner, class_name: "User"
	has_many :tasks, dependent: :destroy
	has_many :teams, foreign_key: "collaboration_project_id", dependent: :destroy
  	has_many :collaborators, through: :teams
	
	validates :name, presence: true, length: { :minimum => 2, :maximum => 50 }
	validates_presence_of :owner_id, :description, :start_date, :due_date, :status
	validates :status, :inclusion => { :in => %w(active complete) }


	scope :overdue, -> { where("due_date < ? AND status = ?", Date.today, 'active')}
	scope :complete, -> { where(status: 'complete') }
	scope :active, -> { where(status: 'active')}


	def collaborator_emails=(emails)
	end

	def collaborator_emails
		emails = self.collaborators.collect { |collaborator| collaborator.email }
    	emails.join(", ")
	end

	def task_group_by_status
		self.tasks.group_by(&:status)
	end

end
