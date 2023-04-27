class AddEndTimeToSets < ActiveRecord::Migration[7.0]
  def change
    add_column :wakeboard_sets, :end_time, :time
  end
end
