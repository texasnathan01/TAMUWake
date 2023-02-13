class CreateReceipts < ActiveRecord::Migration[7.0]
  def change
    drop_table :receipts
    create_table :receipts do |t|
      t.integer :receipt_id
      t.integer :user_id
      t.float :value
      t.date :date_made
      t.date :date_approved
      t.date :date_refunded
      t.integer :stage

      t.timestamps
    end
  end
end
