class WakeboardSet < ApplicationRecord
  has_many :set_riders, dependent: :destroy
  has_many :set_drivers, dependent: :destroy

  validates :dib_count, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :chib_count, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :driver_count, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :scheduled_date, presence: true, not_in_past: true
  validates :end_time, presence: true, allow_blank: false
  validate :counts_under_limit
  validate :end_after_start_time

  # checks to ensure all count attributes are under
  # their respective limits
  def counts_under_limit
    errors.add(:dib_count, "exceeds the dib limit") if dib_count > dib_limit

    errors.add(:chib_count, "exceeds the chib limit") if chib_count > chib_limit

    errors.add(:driver_count, "exceeds the driver limit") if driver_count > driver_limit
  end

  def end_after_start_time
    return if end_time.blank? or scheduled_date.blank?

    # convert end_time to a usuable format with the
    # schedule date, time in ruby is stored with a date
    # see https://stackoverflow.com/questions/34978905/rails-activerecord-postgres-time-format/34979912#34979912
    formatted_end_time = Time.new(
      scheduled_date.year, 
      scheduled_date.month, 
      scheduled_date.day,
      end_time.hour,
      end_time.min,
      end_time.sec,
      scheduled_date.formatted_offset(false)
    )

    errors.add(:end_time, "is before the scheduled start time") if formatted_end_time.before?(scheduled_date.to_time)
  end

  # returns the dates that bound the sets
  # a user is able to join based on the
  # current date. Sundays allow you to join
  # a week in advance but otherwise a user is only
  # able to join sets for the current week
  def self.available_set_range(current_date)
    if current_date.sunday.today?
      return current_date, current_date.next_week.end_of_week
    else
      return current_date, current_date.end_of_week
    end
  end

  # returns true if the set is available for registration
  # on sunday after 8pm
  def self.sunday_registration_open?(scheduled_date, current_date = DateTime.current)
    limit = DateTime.new(current_date.year, current_date.month, current_date.day, 20, 0, 0, current_date.zone)
    if scheduled_date.before?(limit) and scheduled_date.before?(current_date)
      return false
    end
    if current_date.before?(limit) and (scheduled_date.after?(limit) or scheduled_date.to_i == limit.to_i)
      return false
    end
    return true
  end

  # determines if a rider with user_id can
  # join the set. A rider can join if there are
  # open spots (max 4 dibs, 3 chibs) and the rider
  # joins an open set (i.e. the set is not in the past)
  def rider_can_join?(user_id, as_dib)
    return false if !user_id || user_id < 1 || as_dib.nil?

    now = DateTime.current
    lower, upper = WakeboardSet.available_set_range(now)
    if self.scheduled_date.before?(lower) || self.scheduled_date.after?(upper)
      return false
    end

    # after 8pm riders can sign up on sundays
    if now.sunday.today? && !WakeboardSet.sunday_registration_open?(self.scheduled_date, now)
      return false
    end

    return false if SetRider.rider_exists?(user_id, id)

    if as_dib
      return false if dib_count >= dib_limit
    elsif chib_count >= chib_limit
      return false
    end

    true
  end

  # join method which adds an entry in the
  # SetRider table after performing checks on user
  # Called in controller
  # retuns true if successful
  def join(user_id, as_dib)
    return false if !rider_can_join?(user_id, as_dib) || (!user_id || as_dib.nil?)

    rider = SetRider.new(
      date_registered: DateTime.current,
      wakeboard_set_id: id,
      admin_id: user_id,
      as_dib: as_dib
    )

    if as_dib == true
      self.dib_count += 1
    else
      self.chib_count += 1
    end

    transaction do
      save!
      rider.save!
    end

    true
  rescue ActiveRecord::Rollback
    false
  end

  # leave method which attempts to remove the record
  # of the rider being on the set
  def leave(user_id)
    rider = SetRider.find_by(admin_id: user_id, wakeboard_set_id: id)

    # rider isn't on set or set has been completed
    return false if !rider || DateTime.current > scheduled_date

    if rider.as_dib
      self.dib_count -= 1
    else
      self.chib_count -= 1
    end

    transaction do
      rider.destroy!
      save!
    end

    # successfully removed rider
    true
  rescue ActiveRecord::Rollback
    false
  end

  # edit function for sets, allows
  # drivers to edit the start and end
  # time and the secondary driver
  # associated with the set
  def edit(params, user_id, driver_id)
    if user_id.blank?
      return false
    end

    # exit if the person editing is not a driver
    if !self.set_drivers.find { |d| d.admin_id == user_id }
      return false
    end

    # find first driver who is not the current user
    # submitting the edit request (there should only be 2 drivers)
    additional_driver = self.set_drivers.find { |d| d.admin_id != user_id }
    
    # the secondary driver is being replaced
    if additional_driver.try(:admin_id) != driver_id and !driver_id.blank?
      transaction do
        additional_driver.destroy! if !additional_driver.nil?
        SetDriver.create!(wakeboard_set_id: self.id, admin_id: driver_id)
        self.update!(params)
      end

      return true
    # otherwise no change in driver and can simply save the set
    else
      return self.update(params)
    end
  rescue ActiveRecord::Rollback
    return false
  end

  # creates a set with drivers associated
  # a new set does not need to be created with
  # a secondary driver but must have at least
  # one driver (current user creating the set)
  def create_with_driver(user_id, driver_id)
    if user_id.blank?
      return false
    end

    # create 2 new entries in the driver join table
    # and save the new set
    if !driver_id.blank?
      self.driver_count = 2
      transaction do
        self.save!
        SetDriver.create!(wakeboard_set_id: self.id, admin_id: user_id)
        SetDriver.create!(wakeboard_set_id: self.id, admin_id: driver_id)
      end
    else
      self.driver_count = 1
      transaction do
        self.save!
        SetDriver.create!(wakeboard_set_id: self.id, admin_id: user_id)
      end
    end

    return true
  rescue ActiveRecord::Rollback, ActiveRecord::RecordInvalid
    return false
  end
end


