class AddWakeboardSetIdToSetDrivers < ActiveRecord::Migration[7.0]
  def change
    add_column :set_drivers, :wakeboard_set_id, :bigint, null:false
  end
end
