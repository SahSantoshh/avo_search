class AddColumnTempPermissionsToRole < ActiveRecord::Migration[7.1]
  def change
    # add_column :roles, :temp_permissions
    change_table :roles do |t|
      t.string 'tags', array: true
    end
  end
end
