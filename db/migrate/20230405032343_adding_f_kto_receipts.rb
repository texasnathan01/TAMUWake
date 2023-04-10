class AddingFKtoReceipts < ActiveRecord::Migration[7.0]
  def change
    remove_column :receipts, :user_id,  if_exists: true
    add_reference :receipts, :admin, foreign_key: true
  end
end
