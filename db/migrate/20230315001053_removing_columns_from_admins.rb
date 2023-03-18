class RemovingColumnsFromAdmins < ActiveRecord::Migration[7.0]
  def change
    remove_column :admins, :role_ID
    remove_column :admins, :full_name
    remove_column :admins, :is_approved
  end
end
