class AddisApprovedAttributetoAdmins < ActiveRecord::Migration[7.0]
  def change
    add_column :admins, :isApproved, :boolean, :default => false

    remove_reference :users, :set_riders, index: true, foreign_key: true

    add_reference :set_riders, :user, foreign_key: true
  end
end
