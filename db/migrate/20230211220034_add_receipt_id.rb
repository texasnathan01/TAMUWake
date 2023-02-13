class AddReceiptId < ActiveRecord::Migration[7.0]
  def change
    drop_table :receipts
  end
end
