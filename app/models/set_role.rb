class SetRole < ApplicationRecord
  belongs_to :role_id
  belongs_to :user_id
end
