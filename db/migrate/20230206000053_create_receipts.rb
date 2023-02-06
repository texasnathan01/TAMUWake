class CreateReceipts < ActiveRecord::Migration[7.0]
  def change
    create_table :receipts do |t|
      t.float :value
      t.string :driver
      t.date :date

      t.timestamps
    end
  end
end
