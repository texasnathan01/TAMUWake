class CreateSetDrivers < ActiveRecord::Migration[7.0]
  def change
    create_table :set_drivers do |t|

      t.timestamps
    end
  end
end
