class AddDefaultAndNotNullToMembershipsRole < ActiveRecord::Migration[8.1]
  def change
    change_column_default :memberships, :role, from: nil, to: 0
    change_column_null :memberships, :role, false
  end
end
