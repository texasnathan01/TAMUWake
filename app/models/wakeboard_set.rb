class WakeboardSet < ApplicationRecord
    validates :rider_limit, presence: true, numericality: { only_integer: true, greater_than: 0 }
    validates :scheduled_date, presence: true, not_in_past: true
    validate :current_rider_under_limit, on: :update

    def current_rider_under_limit
        if current_rider_count > rider_limit
            errors.add(:current_rider_count, "exceeds the rider limit")
        end
    end
end
