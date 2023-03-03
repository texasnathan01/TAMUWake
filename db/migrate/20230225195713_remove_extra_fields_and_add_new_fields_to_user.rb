class RemoveExtraFieldsAndAddNewFieldsToUser < ActiveRecord::Migration[7.0]
  def up
    remove_column :users, :isAdmin
    remove_column :users, :isTreasurer
    remove_column :users, :isRider
    remove_column :users, :isDriver
  end

  def down  
    add_column :users, :isAdmin, :boolean
    add_column :users, :isTreasurer, :boolean
    add_column :users, :isRider, :boolean
    add_column :users, :isDriver, :boolean
  end

  add_index :users, :email, unique: true
end