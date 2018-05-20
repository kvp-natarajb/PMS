class CreateTeams < ActiveRecord::Migration[5.0]
  def change
    create_table :teams do |t|
      t.belongs_to :collaborator, class_name: "User"
      t.belongs_to :collaboration_project, class_name: "Project"
      t.integer :permission, default: 0
    end
  end
end
