class CreateSetRoles < ActiveRecord::Migration[7.0]
  def change
    create_table :set_roles do |t|
      t.references :role, null: false, foreign_key: true
    end
  end
end
