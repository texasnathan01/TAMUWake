class RemoveUsersIdFromSetDrivers < ActiveRecord::Migration[7.0]
  def change
    remove_column :set_drivers, :users_id, :bigint
  end
end
