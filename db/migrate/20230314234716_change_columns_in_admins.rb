class ChangeColumnsInAdmins < ActiveRecord::Migration[7.0]
  def change
    change_column_default :admins, :role_id, from: 0, to: -1
  end
end
