class AddUserRelationToWakeboardSet < ActiveRecord::Migration[7.0]
  def change
    add_belongs_to :wakeboard_sets, :users
  end
end
