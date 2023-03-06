class AddImageLinkToReceipts < ActiveRecord::Migration[7.0]
  def change
    add_column :receipts, :image_link, :string
  end
end
