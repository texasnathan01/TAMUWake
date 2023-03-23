class ChangingFKinSetRiderandWakeBoardSets < ActiveRecord::Migration[7.0]
  def change
    add_reference :set_riders, :admin,  index: true, foreign_key: true
    remove_reference :wakeboard_sets, :admin, foreign_key: true
    change_column_default :admins, :role_id, from: -1, to: 0
  end
end
