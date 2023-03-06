class CreateSetRiders < ActiveRecord::Migration[7.0]
  def change
    create_table :set_riders do |t|
      t.timestamp :date_registered
      t.references :rider, null: false, foreign_key: true
      t.references :wakeboard_set, null: false, foreign_key: true

      t.timestamps
    end
  end
end
