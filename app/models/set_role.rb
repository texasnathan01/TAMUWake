class SetRole < ApplicationRecord
  belongs_to :role
  belongs_to :admin
  validates :admin_id, presence: true
end
