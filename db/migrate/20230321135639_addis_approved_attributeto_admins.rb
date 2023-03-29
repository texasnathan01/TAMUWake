class AddisApprovedAttributetoAdmins < ActiveRecord::Migration[7.0]
  def change
    add_column :admins, :isApproved, :boolean, :default => false
    add_column :admins, :uin, :integer
    add_column :admins, :address, :string

    remove_reference  :wakeboard_sets, :user, index: true, foreign_key: true
    remove_reference :set_riders, :user,  index: true, foreign_key: true

    add_reference :wakeboard_sets, :admin, foreign_key: true
  end
end
