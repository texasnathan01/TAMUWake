class CreateSetRoles < ActiveRecord::Migration[7.0]
  def change
    create_table :set_roles do |t|
      t.references :role_id, null: false, foreign_key: true
      t.references :user_id, null: false, foreign_key: true

      t.timestamps
    end
  end
end
