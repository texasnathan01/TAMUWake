class DestroyingRidersModel < ActiveRecord::Migration[7.0]
  def change
    drop_table(:riders, force: :cascade, if_exists: true)
    remove_index(:set_riders, :rider_id)
    add_reference(:set_riders, :user, foreign_key: true)
  end
end
