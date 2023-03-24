class RenameIsApproved < ActiveRecord::Migration[7.0]
  def change
    rename_column :admins, :isApproved, :is_approved
  end
end
