class AddingDefaultstoAdminAttributes < ActiveRecord::Migration[7.0]
  def change
    change_column :admins, :uin, :string, :default => ""
    change_column :admins, :address, :string, :default => ""
  end
end
