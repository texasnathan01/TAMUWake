class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :email
      t.string :firstname
      t.string :lastname
      t.string :password
      t.boolean :isRider
      t.boolean :isDriver
      t.boolean :isAdmin
      t.boolean :isTreasurer

      t.timestamps
    end
  end
end
