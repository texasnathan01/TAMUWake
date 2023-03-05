class CreateWakeboardSets < ActiveRecord::Migration[7.0]
  def change
    create_table :wakeboard_sets do |t|
      t.integer :rider_limit
      t.integer :current_rider_count
      t.timestamp :scheduled_date

      t.timestamps
    end
  end
end
