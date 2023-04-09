class ChangingFKinSetRiderandWakeBoardSets < ActiveRecord::Migration[7.0]
  def change
    remove_reference :wakeboard_sets, :admin, foreign_key: true
    add_column :admins, :role_id, :int, :default => 0
  end
end
