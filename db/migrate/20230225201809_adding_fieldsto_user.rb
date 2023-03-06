class AddingFieldstoUser < ActiveRecord::Migration[7.0]
  def change 
    add_column :users, :documents_signed, :boolean, :default => false
    add_column :users, :role_id, :int, :default => 0
  end
end
