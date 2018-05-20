class CreateTasks < ActiveRecord::Migration[5.0]
  def change
    create_table :tasks do |t|
      t.string :name
      t.string :description
      t.date :start_date
      t.date :due_date
      t.integer :status
      t.integer :percentage, :default => 0
      t.references :project, foreign_key: true
      t.integer :owner_id

      t.timestamps
    end
  end
end
