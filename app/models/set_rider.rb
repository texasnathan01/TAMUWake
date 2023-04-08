class SetRider < ApplicationRecord
  belongs_to :admin
  belongs_to :wakeboard_set

  # rider_exists(user, set) method
  # user: integer, id of the user
  # set: integer, id of the set to check for
  #     the user on
  # this method returns a boolean value, true
  # if the array returned by a where query has
  # a size greater than 0
  def self.rider_exists?(user, set)
    return false if !user || !set

    set = where(wakeboard_set_id: set, admin_id: user)
    !set.empty?
  end
end
