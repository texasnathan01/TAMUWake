require 'rails_helper'

RSpec.describe WakeboardSet, type: :model do
    subject do
        described_class.new(
            rider_limit: 7,
            current_rider_count: 0,
            scheduled_date: (DateTime.current).tomorrow,
            user_id: 3
        )
    end

    it 'is valid with positive rider limit and rider count < limit' do
        expect(subject).to be_valid
    end

    it 'is not valid for negative rider limits' do
        subject.rider_limit = -1
        expect(subject).not_to be_valid
    end

    it 'is not valid when current rider count is > rider limit' do
        subject.rider_limit = 2
        subject.current_rider_count = 3
        expect(subject.current_rider_count).to be > subject.rider_limit
        expect(subject).not_to be_valid
    end

    it 'is not valid when scheduled date is in the past' do
        now = DateTime.current
        subject.scheduled_date = now.days_ago(1)
        expect(subject.scheduled_date.prev_day?).to be true
        expect(subject).not_to be_valid
    end
end