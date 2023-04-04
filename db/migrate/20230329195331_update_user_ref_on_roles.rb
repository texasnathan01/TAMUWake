class UpdateUserRefOnRoles < ActiveRecord::Migration[7.0]
  def change
    add_reference :set_roles, :admin, foreign_key: true
  end
end
