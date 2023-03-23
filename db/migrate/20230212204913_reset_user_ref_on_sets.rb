class ResetUserRefOnSets < ActiveRecord::Migration[7.0]
  def change
    remove_reference :wakeboard_sets, :users, foreign_key: false, index: true
    add_reference :wakeboard_sets, :user, foreign_key: true
  end
end
