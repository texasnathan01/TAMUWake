class CreateRoles < ActiveRecord::Migration[7.0]
  def change
    create_table :roles do |t|
      t.integer :role_id, null: false
      t.string :role_name, null: false

      t.timestamps
    end
  end
end
