class CreateJoinTableForRolesAndPermission < ActiveRecord::Migration[7.1]
  def change
    create_join_table :roles, :permissions
  end
end
