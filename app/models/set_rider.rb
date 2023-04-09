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

  # returns true if a rider has joined a set between a
  # minimum datetime and maximum datetime
  def self.rider_joined_between?(user_id, min_date, max_date)
    sets_joined = where([
      "admin_id = ? AND date_registered >= ? AND date_registered <= ?", 
      user_id, 
      min_date, 
      max_date
    ])
    return sets_joined.length > 0
  end
end
