module WakeboardSetsHelper
  # same as rider_can_join method in WakeboardSets model
  # without dib and chib limits
  def set_available?(user_id, set, current_date = DateTime.current)
    if current_date.sunday.today?
      # sunday registration opens at 8pm
      if !WakeboardSet.sunday_registration_open?(set.scheduled_date, current_date)
        return false
      end

      # otherwise, registration is open but only 1 set can be joined by the user
      registration = DateTime.new(current_date.year, current_date.month, current_date.day, 20, 0, 0)
      lower, upper = WakeboardSet.available_set_range(registration)
      return !SetRider.rider_joined_between?(user_id, lower, upper)

    else
      return !SetRider.rider_exists?(current_admin.id, set.id)
    end
  end
end
