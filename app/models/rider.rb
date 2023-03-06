class Rider < ApplicationRecord
  belongs_to :user
  has_many :set_rider
end
