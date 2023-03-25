module WakeboardSetsHelper
  # get the range of available set dates
  # on sundays, the range opens to the next week
  # until the following sunday
  def available_set_range(currentDate)
    if currentDate.sunday.today?
      return currentDate, currentDate.next_week.end_of_week
    else
      return currentDate, currentDate.end_of_week
    end
  end
end
