class FixUserRelationOnSetDriver < ActiveRecord::Migration[7.0]
  def change
    #remove_reference :set_drivers, :rider
    #add_reference :set_drivers, :admin, index: true, foreign_key: true
    #add_reference :set_drivers, :wakeboard_set, index: true, foreign_key: true
  end
end
