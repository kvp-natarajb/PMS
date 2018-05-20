class Task < ApplicationRecord
  belongs_to :project
  belongs_to :owner, class_name: "User"
  has_many :user_tasks, foreign_key: "assigned_task_id", dependent: :destroy
  has_many :assigned_users, through: :user_tasks

  enum status: [:new_task, :in_progress, :done]

  scope :status, lambda{|status| where(status: status)}

  validates_presence_of :name, :owner_id, :description, :start_date, :due_date, :status, :project_id
  validates :status, :inclusion => { :in => %w(new_task in_progress done) }
end
