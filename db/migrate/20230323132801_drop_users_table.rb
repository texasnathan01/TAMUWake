class DropUsersTable < ActiveRecord::Migration[7.0]
  def change
    drop_table :users, force: :cascade, if_exists: true
  end
end
