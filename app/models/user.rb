class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  enum role: [:developer, :admin]

  has_many :projects, foreign_key: "owner_id", dependent: :destroy
  has_many :teams, foreign_key: "collaborator_id", dependent: :destroy
  has_many :collaboration_projects, through: :teams
  has_many :tasks, foreign_key: "owner_id", dependent: :destroy
  has_many :user_tasks, foreign_key: "assigned_user_id", dependent: :destroy
  has_many :assigned_tasks, through: :user_tasks

  scope :role, lambda{|role| where(role: role)}

  validates_presence_of :full_name, :role
  validates_format_of :email,:with => Devise::email_regexp
  validates :role, :inclusion => { :in => %w(developer admin) }

  def role?(role_name)
    role == role_name
  end

  def all_active_projects
    self.projects.active + self.collaboration_projects
  end

  def active_projects
    self.projects.active 
  end

  def task_group_by_status(project_id)
    self.assigned_tasks.where(project_id: project_id).group_by(&:status)
  end

end
