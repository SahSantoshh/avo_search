class CreatePermissions < ActiveRecord::Migration[7.1]
  def change
    create_table :permissions do |t|
      t.string :name
      t.text :description
      t.string :controller
      t.string :controller_method

      t.timestamps
    end
  end
end
