class WakeboardSet < ApplicationRecord
    has_many :set_rider

    validates :dib_count, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
    validates :chib_count, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
    validates :driver_count, presence: true, numericality: { only_integer: true, greater_than: 0 }
    validates :scheduled_date, presence: true, not_in_past: true
    validate :counts_under_limit

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
end
