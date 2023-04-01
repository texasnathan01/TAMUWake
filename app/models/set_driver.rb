class SetDriver < ApplicationRecord
  belongs_to :admin
  belongs_to :wakeboard_set

  # driver_exists(user, set) method
  # user: integer, id of the user
  # set: integer, id of the set to check for
  #     the user on
  # this method returns a boolean value, true
  # if the array returned by a where query has
  # a size greater than 0
  def self.driver_exists?(user, set)
    if !user || !set
      return false
    end

    set = where(wakeboard_set_id: set, admin_id: user)
    return set.length != 0
  end
end
