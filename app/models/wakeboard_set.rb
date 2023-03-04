class WakeboardSet < ApplicationRecord
  has_many :set_rider

  validates :dib_count, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :chib_count, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :driver_count, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :scheduled_date, presence: true, not_in_past: true
  validate :counts_under_limit

  # checks to ensure all count attributes are under
  # their respective limits
  def counts_under_limit
    if dib_count > dib_limit
      errors.add(:dib_count, "exceeds the dib limit")
    end

    if chib_count > chib_limit
      errors.add(:chib_count, "exceeds the chib limit")
    end

    if driver_count > driver_limit
      errors.add(:driver_count, "exceeds the driver limit")
    end
  end

  # determines if a rider with user_id can
  # join the set. A rider can join if there are
  # open spots (max 4 dibs, 3 chibs) and the rider
  # joins an open set (i.e. the set is not in the past)
  def rider_can_join(user_id, as_dib)
    if !user_id || as_dib == nil
      return false
    end

    now = DateTime.current
    if (self.scheduled_date < now)
      return false
    end

    if SetRider.rider_exists(user_id, self.id)
      return false
    end

    if as_dib
      if self.dib_count >= self.dib_limit
        return false
      end
    else
      if self.chib_count >= self.chib_limit
        return false
      end
    end

    return true
  end

  # join method which adds an entry in the
  # SetRider table after performing checks on user
  # Called in controller
  # retuns true if successful
  def join(user_id, as_dib)
    if !rider_can_join(user_id, as_dib) || (!user_id || as_dib == nil)
      return false
    end

    rider = SetRider.new(
      date_registered: DateTime.current,
      wakeboard_set_id: self.id,
      user_id: user_id,
      as_dib: as_dib
    )

    if (as_dib)
      self.dib_count += 1
    else
      self.chib_count += 1
    end

    self.transaction do
      self.save!
      rider.save
    end

    return true
  rescue ActiveRecord::Rollback
    return false
  end
end
