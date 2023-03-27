class AddUsersAttributesToAdmins < ActiveRecord::Migration[7.0]
  def change 
    add_column :admins, :documents_signed, :boolean, :default => false
    add_column :admins, :role_id, :int, :default => -1
    add_column :admins, :first_name, :string
    add_column :admins, :last_name, :string
  end
end
