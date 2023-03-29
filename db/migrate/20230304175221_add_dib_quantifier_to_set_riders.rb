class AddDibQuantifierToSetRiders < ActiveRecord::Migration[7.0]
  def change
    add_column(:set_riders, :as_dib, :boolean)
  end
end
