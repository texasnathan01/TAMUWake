class CreateSetDrivers < ActiveRecord::Migration[7.0]
  def change
    create_table :set_drivers do |t|
	    t.references :admin, null: false, foreign_key: true
      t.references :wakeboard_set, null: false, foreign_key: true

      t.timestamps
    end
  end
end
