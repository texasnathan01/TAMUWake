class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :email
      t.string :firstname
      t.string :lastname
      t.text :password
      t.integer :roleID

      t.timestamps
    end
  end
end
