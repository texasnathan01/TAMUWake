class SetRole < ApplicationRecord
  belongs_to :role
  belongs_to :user
  validates :user_id, presence: true
end
