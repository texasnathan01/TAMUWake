class RemovedRoleIdFromRoles < ActiveRecord::Migration[7.0]
  def change
    remove_column :roles, :role_id
  end
end
