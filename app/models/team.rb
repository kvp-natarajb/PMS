class Team < ApplicationRecord

	enum status: [:active, :complete]

	belongs_to :collaboration_project, class_name: "Project"
  	belongs_to :collaborator, class_name: "User"

end
