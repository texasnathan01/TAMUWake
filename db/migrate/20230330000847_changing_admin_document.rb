class ChangingAdminDocument < ActiveRecord::Migration[7.0]
  def change
    remove_column :admins, :documents_signed,  if_exists: true
    add_column :admins, :aor_completed, :boolean, :default => false
    add_column :admins, :boat_waiver_completed,:boolean, :default=> false
    add_column :admins, :dues_completed,:boolean, :default=> false
  end
end
