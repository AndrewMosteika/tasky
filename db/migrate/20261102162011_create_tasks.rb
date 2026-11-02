class CreateTasks < ActiveRecord::Migration[8.1]
  def change
    create_table :tasks do |t|
      t.references :project, null: false, foreign_key: true
      t.string :title
      t.text :description
      t.integer :status, default: 0, null: false
      t.date :due_on

      t.timestamps
    end
  end
end
