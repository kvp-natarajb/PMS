class CreateProjects < ActiveRecord::Migration[5.0]
  def change
    create_table :projects do |t|
      t.string :name
      t.integer :owner_id
      t.string :description
      t.date :start_date
      t.date :due_date
      t.integer :status

      t.timestamps
    end
  end
end
