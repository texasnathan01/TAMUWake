class AddRiderIdToSetDrivers < ActiveRecord::Migration[7.0]
  def change
    add_column :set_drivers, :rider_id, :bigint, null:false
  end
end
