class CreateMemberships < ActiveRecord::Migration[8.1]
  def change
    create_table :memberships do |t|
      t.references :user, null: false, foreign_key: true
      t.references :project, null: false, foreign_key: true
      t.integer :role
      t.timestamps
      t.index [ :user_id, :project_id ], unique: true
    end
  end
end
