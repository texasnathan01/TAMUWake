require 'rails_helper'
require 'time_helpers'

RSpec.describe WakeboardSet, type: :model do
#   subject do
#     described_class.new(
#       dib_count: 0,
#       chib_count: 0,
#       driver_count: 1,
#       scheduled_date: (DateTime.current).tomorrow,
#     )
#   end

#   before(:example) do
#     expect(subject).to be_valid
#   end

#   it 'is valid with positive 0 dibs and chibs, date tomorrow, and driver count 1' do
#     expect(subject).to be_valid
#   end

#   it 'is not valid for driver count = 0' do
#     subject.driver_count = 0
#     expect(subject).not_to be_valid
#   end

#   it 'is not valid for negative dib, chib, and driver limits' do
#     subject.dib_limit = -1
#     expect(subject).not_to be_valid

#     subject.dib_limit = 4
#     expect(subject).to be_valid

#     subject.chib_limit = -1
#     expect(subject).not_to be_valid

#     subject.chib_limit = 3
#     expect(subject).to be_valid

#     subject.driver_limit = -1
#     expect(subject).not_to be_valid
#   end

#   it 'is not valid for negative dib, chib, and driver counts' do
#     subject.dib_count = -1
#     expect(subject).not_to be_valid

#     subject.dib_count = 0
#     expect(subject).to be_valid

#     subject.chib_count = -1
#     expect(subject).not_to be_valid

#     subject.chib_count = 0
#     expect(subject).to be_valid

#     subject.driver_count = -1
#     expect(subject).not_to be_valid
#   end

#   it 'is not valid when current dib count is > dib limit' do
#     subject.dib_limit = 2
#     subject.dib_count = 3
#     expect(subject.dib_count).to be > subject.dib_limit
#     expect(subject).not_to be_valid
#   end

#   it 'is valid when current dib count is = dib limit' do
#     subject.dib_limit = 3
#     subject.dib_count = 3
#     expect(subject.dib_count).to eq(subject.dib_limit)
#     expect(subject).to be_valid
#   end

#   it 'is not valid when current chib count is > chib limit' do
#     subject.chib_limit = 2
#     subject.chib_count = 3
#     expect(subject.chib_count).to be > subject.chib_limit
#     expect(subject).not_to be_valid
#   end

#   it 'is valid when current chib count is = chib limit' do
#     subject.chib_limit = 3
#     subject.chib_count = 3
#     expect(subject.chib_count).to eq(subject.chib_limit)
#     expect(subject).to be_valid
#   end

#   it 'is not valid when scheduled date is in the past' do
#     now = DateTime.current
#     subject.scheduled_date = now.days_ago(1)
#     expect(subject.scheduled_date.prev_day?).to be true
#     expect(subject).not_to be_valid
#   end

#   describe 'join helper methods - rider_can_join' do
#     before :each do
#       @user = Admin.find_or_create_by(email: "aramone@tamu.edu")
#       @set = WakeboardSet.create(
#         dib_count: 0,
#         chib_count: 0,
#         driver_count: 1,
#         scheduled_date: (DateTime.current).tomorrow
#       )
#     end

#     it 'is true when a rider is not on the set, as a dib' do
#       as_dib = true
#       result = @set.rider_can_join(@user.id, as_dib)
#       expect(result).to be true
#     end

#     it 'is true when a rider is not on the set, as a chib' do
#       as_dib = false
#       result = @set.rider_can_join(@user.id, as_dib)
#       expect(result).to be true
#     end

#     it 'is false when a rider is on the set as dib, joins as dib' do
#       as_dib = true
#       joined = @set.join(@user.id, as_dib)
#       expect(joined).to be true
#       result = @set.rider_can_join(@user.id, as_dib)
#       expect(result).to be false
#     end

#     it 'is false when a rider is on the set as dib, joins as chib' do
#       as_dib = true
#       joined = @set.join(@user.id, as_dib)
#       expect(joined).to be true
#       result = @set.rider_can_join(@user.id, !as_dib)
#       expect(result).to be false
#     end

#     it 'is false when a rider is on the set as chib, joins as chib' do
#       as_dib = false
#       joined = @set.join(@user.id, as_dib)
#       expect(joined).to be true
#       result = @set.rider_can_join(@user.id, as_dib)
#       expect(result).to be false
#     end

#     it 'is false when a rider is on the set as chib and joins as dib' do
#       as_dib = false
#       joined = @set.join(@user.id, as_dib)
#       expect(joined).to be true
#       result = @set.rider_can_join(@user.id, !as_dib)
#       expect(result).to be false
#     end

#     it 'is false when a userid is nil' do
#       as_dib = true
#       result = @set.rider_can_join(nil, as_dib)
#       expect(result).to be false
#     end

#     it 'is false when a userid is negative' do
#       as_dib = true
#       result = @set.rider_can_join(-1, as_dib)
#       expect(result).to be false
#     end

#     it 'is false when a userid is negative and as_dib is nil' do
#       result = @set.rider_can_join(-1, nil)
#       expect(result).to be false
#     end

#     it 'is false when a userid is valid and as_dib is nil' do
#       result = @set.rider_can_join(1, nil)
#       expect(result).to be false
#     end

#     it 'is false when schedule date and as_dib is nil' do
#       @set.scheduled_date = DateTime.current.prev_day()
#       result = @set.rider_can_join(1, true)
#       expect(result).to be false
#     end

#     it 'is false when dib_count is = dib_limit' do
#       @set.dib_count = 4
#       expect(@set.dib_count).to eq(@set.dib_limit)
#       as_dib = true
#       result = @set.rider_can_join(1, as_dib)
#       expect(result).to be false
#     end

#     it 'is false when chib_count is = chib_limit' do
#       @set.chib_count = 3
#       expect(@set.chib_count).to eq(@set.chib_limit)
#       as_dib = false
#       result = @set.rider_can_join(1, as_dib)
#       expect(result).to be false
#     end

#     it 'is true when chib_count is = chib_limit - 1' do
#       @set.chib_count = 2
#       expect(@set.chib_count).to eq(@set.chib_limit - 1)
#       as_dib = false
#       result = @set.rider_can_join(1, as_dib)
#       expect(result).to be true
#     end

#     it 'is true when dib_count is = dib_limit - 1' do
#       @set.dib_count = 3
#       expect(@set.dib_count).to eq(@set.dib_limit - 1)
#       as_dib = true
#       result = @set.rider_can_join(1, as_dib)
#       expect(result).to be true
#     end
#   end

  describe 'rider_can_join?' do
    let(:set) {WakeboardSet.create(
      dib_count: 0,
      chib_count: 0,
      driver_count: 1,
      scheduled_date: (DateTime.current).tomorrow
    )}
    let(:user) { Admin.create(email: "aramone@tamu.edu", first_name: "Axel", last_name: "Ramone") }

    before :each do
      #@user = Admin.find_or_create_by(email: "aramone@tamu.edu")
    end

    it 'is true when a rider is not on the set, as a dib' do
      as_dib = true
      result = set.rider_can_join?(user.id, as_dib)
      expect(result).to be true
    end

    it 'is true when a rider is not on the set, as a chib' do
      as_dib = false
      result = set.rider_can_join?(user.id, as_dib)
      expect(result).to be true
    end

    it 'is false when a rider is on the set as dib, joins as dib' do
      as_dib = true
      joined = set.join(user.id, as_dib)
      expect(joined).to be true
      result = set.rider_can_join?(user.id, as_dib)
      expect(result).to be false
    end

    it 'is false when a rider is on the set as dib, joins as chib' do
      as_dib = true
      joined = set.join(user.id, as_dib)
      expect(joined).to be true
      result = set.rider_can_join?(user.id, !as_dib)
      expect(result).to be false
    end

    it 'is false when a rider is on the set as chib, joins as chib' do
      as_dib = false
      joined = set.join(user.id, as_dib)
      expect(joined).to be true
      result = set.rider_can_join?(user.id, as_dib)
      expect(result).to be false
    end

    it 'is false when a rider is on the set as chib and joins as dib' do
      as_dib = false
      joined = set.join(user.id, as_dib)
      expect(joined).to be true
      result = set.rider_can_join?(user.id, !as_dib)
      expect(result).to be false
    end

    it 'is false when a userid is nil' do
      as_dib = true
      result = set.rider_can_join?(nil, as_dib)
      expect(result).to be false
    end

    it 'is false when a userid is negative' do
      as_dib = true
      result = set.rider_can_join?(-1, as_dib)
      expect(result).to be false
    end

    it 'is false when a userid is negative and as_dib is nil' do
      result = set.rider_can_join?(-1, nil)
      expect(result).to be false
    end

    it 'is false when a userid is valid and as_dib is nil' do
      result = set.rider_can_join?(1, nil)
      expect(result).to be false
    end

    it 'is false when schedule date and as_dib is nil' do
      set.scheduled_date = DateTime.current.prev_day()
      result = set.rider_can_join?(1, true)
      expect(result).to be false
    end

    it 'is false when dib_count is = dib_limit' do
      set.dib_count = 4
      expect(set.dib_count).to eq(set.dib_limit)
      as_dib = true
      result = set.rider_can_join?(1, as_dib)
      expect(result).to be false
    end

    it 'is false when chib_count is = chib_limit' do
      set.chib_count = 3
      expect(set.chib_count).to eq(set.chib_limit)
      as_dib = false
      result = set.rider_can_join?(1, as_dib)
      expect(result).to be false
    end

    it 'is true when chib_count is = chib_limit - 1' do
      set.chib_count = 2
      expect(set.chib_count).to eq(set.chib_limit - 1)
      as_dib = false
      result = set.rider_can_join?(1, as_dib)
      expect(result).to be true
    end

    it 'is true when dib_count is = dib_limit - 1' do
      set.dib_count = 3
      expect(set.dib_count).to eq(set.dib_limit - 1)
      as_dib = true
      result = set.rider_can_join?(1, as_dib)
      expect(result).to be true
    end
  end

  describe 'available_set_range' do
    it 'returns the current date - this week\'s sunday when today isn\'t sunday' do
      today = (DateTime.current.sunday.today?) ? DateTime.current.beginning_of_week : DateTime.current
      lower, upper = WakeboardSet.available_set_range(today)
      sunday = today.sunday
      max = DateTime.new(sunday.year, sunday.month, sunday.day, 23, 59, 59)
      expect(lower).to be_within(1.second).of today
      expect(upper).to be_within(1.second).of max
    end

    it 'returns the sunday - next sunday when today is sunday' do
      today = DateTime.current.sunday
      travel_to today
      lower, upper = WakeboardSet.available_set_range(today)
      sunday = today.next_week.sunday
      max = DateTime.new(sunday.year, sunday.month, sunday.day, 23, 59, 59)
      expect(lower).to be_within(1.second).of today
      expect(upper).to be_within(1.second).of max
      travel_back
    end
  end

  describe 'sunday_registration_open?' do
    after :each do
      travel_back
    end

    it 'is false when it is 7:59 on Sunday' do
      # 7:59pm on Sunday 04-09-2023
      now = DateTime.new(2023, 4, 9, 19, 59, 59)
      # 4:30pm on Monday 04-10-2023
      set_date = DateTime.new(2023, 4, 10, 16, 30, 0)
      
      travel_to now
      result = WakeboardSet.sunday_registration_open?(set_date)
      expect(result).to be false
    end

    it 'is true when it is 8pm on Sunday' do
      # pm on Sunday 04-09-2023
      now = DateTime.new(2023, 4, 9, 20, 0, 0)
      # 4:30pm on Monday 04-10-2023
      set_date = DateTime.new(2023, 4, 10, 16, 30, 0)
      
      travel_to now
      result = WakeboardSet.sunday_registration_open?(set_date)
      expect(result).to be true
    end

    it 'is false when it is 8:01pm on Sunday but set date is in past' do
      # pm on Sunday 04-09-2023
      now = DateTime.new(2023, 4, 9, 20, 1, 0)
      # 4:30pm on Sunday 04-09-2023
      set_date = DateTime.new(2023, 4, 9, 16, 30, 0)
      
      travel_to now
      result = WakeboardSet.sunday_registration_open?(set_date)
      expect(result).to be false
    end
  end

  describe 'join method' do
    let(:set) {WakeboardSet.create(
      dib_count: 0,
      chib_count: 0,
      driver_count: 1,
      scheduled_date: (DateTime.new(2023, 4, 7, 8, 0, 0))
    )}
    let(:user) { Admin.create(email: "aramone@tamu.edu", first_name: "Axel", last_name: "Ramone") }

    it 'increments the dib count when rider joins as a dib' do
      as_dib = true
      now = set.scheduled_date.advance(hours: -1)
      expect(now).to be < set.scheduled_date
      travel_to now
      expect(set.dib_count).to eq(0)
      expect(set.chib_count).to eq(0)
      expect(SetRider.find_by(admin_id: user.id, wakeboard_set_id: set.id)).to be nil
      result = set.join(user.id, as_dib)
      expect(result).to be true
      expect(set.dib_count).to eq(1)
      expect(set.chib_count).to eq(0)
      expect(SetRider.find_by(admin_id: user.id, wakeboard_set_id: set.id)).to be_an_instance_of(SetRider)
      expect(SetRider.find_by(admin_id: user.id, wakeboard_set_id: set.id).as_dib).to be true
      travel_back
    end

    it 'increments the chib count when a rider joins as a chib' do
      as_dib = false
      now = set.scheduled_date.advance(hours: -1)
      expect(now).to be < set.scheduled_date
      travel_to now
      expect(set.dib_count).to eq(0)
      expect(set.chib_count).to eq(0)
      expect(SetRider.find_by(admin_id: user.id, wakeboard_set_id: set.id)).to be nil
      result = set.join(user.id, as_dib)
      expect(result).to be true
      expect(set.dib_count).to eq(0)
      expect(set.chib_count).to eq(1)
      expect(SetRider.find_by(admin_id: user.id, wakeboard_set_id: set.id)).to be_an_instance_of(SetRider)
      expect(SetRider.find_by(admin_id: user.id, wakeboard_set_id: set.id).as_dib).to be false
      travel_back
    end
  end

  describe 'leave method' do
    let(:set) {WakeboardSet.create(
      dib_count: 0,
      chib_count: 0,
      driver_count: 1,
      scheduled_date: (DateTime.new(2023, 4, 7, 8, 0, 0))
    )}
    let(:user) { Admin.create(email: "aramone@tamu.edu", first_name: "Axel", last_name: "Ramone") }

    it 'returns false if the rider isn\'t on the set' do
      expect(SetRider.find_by(admin_id: user.id, wakeboard_set_id: set.id)).to be nil
      expect(set.dib_count).to eq(0)
      expect(set.chib_count).to eq(0)
      result = set.leave(user.id)
      expect(result).to be false
      expect(SetRider.find_by(admin_id: user.id, wakeboard_set_id: set.id)).to be nil
      expect(set.dib_count).to eq(0)
      expect(set.chib_count).to eq(0)
    end

    it 'returns false when the current date is > scheduled set date' do
      as_dib = true
      travel_to set.scheduled_date.advance(hours: -1)
      set.join(user.id, as_dib)
      expect(SetRider.find_by(admin_id: user.id, wakeboard_set_id: set.id)).to be_an_instance_of(SetRider)
      now = set.scheduled_date.advance(hours: 1)
      travel_to now
      expect(now).to be > set.scheduled_date
      expect(set.dib_count).to eq(1)
      expect(set.chib_count).to eq(0)
      result = set.leave(user.id)
      expect(result).to be false
      expect(set.dib_count).to eq(1)
      expect(set.chib_count).to eq(0)
      travel_back
    end

    it 'decrements dib count when rider is on set as dib and can leave' do
      as_dib = true
      now = set.scheduled_date.advance(hours: -1)
      expect(now).to be < set.scheduled_date
      travel_to now
      set.join(user.id, as_dib)
      expect(SetRider.find_by(admin_id: user.id, wakeboard_set_id: set.id)).to be_an_instance_of(SetRider)
      expect(set.dib_count).to eq(1)
      expect(set.chib_count).to eq(0)
      result = set.leave(user.id)
      expect(result).to be true
      expect(SetRider.find_by(admin_id: user.id, wakeboard_set_id: set.id)).to be nil
      expect(set.dib_count).to eq(0)
      expect(set.chib_count).to eq(0)
      travel_back
    end

    it 'decrements chib count when rider is on set as chib' do
      as_dib = false
      now = set.scheduled_date.advance(hours: -1)
      expect(now).to be < set.scheduled_date
      travel_to now
      set.join(user.id, as_dib)
      expect(SetRider.find_by(admin_id: user.id, wakeboard_set_id: set.id)).to be_an_instance_of(SetRider)
      expect(set.dib_count).to eq(0)
      expect(set.chib_count).to eq(1)
      result = set.leave(user.id)
      expect(result).to be true
      expect(SetRider.find_by(admin_id: user.id, wakeboard_set_id: set.id)).to be nil
      expect(set.dib_count).to eq(0)
      expect(set.chib_count).to eq(0)
      travel_back
    end
  end
end

RSpec.describe WakeboardSetsHelper, type: :helper do

end

RSpec.describe SetRider, type: :model do
  describe 'rider_exists method' do
    it 'is false when user_id is nil' do
      expect(SetRider.rider_exists?(nil, 3)).to be false
    end

    it 'is false when set_id is nil' do
      expect(SetRider.rider_exists?(3, nil)).to be false
    end
  end

  describe 'rider_joined_between method' do
    let(:user) { Admin.create(email: "aramone@tamu.edu", first_name: "Axel", last_name: "Ramone") }
    
    it 'is false when rider hasn\'t joined a set' do
      min = DateTime.yesterday
      max = DateTime.tomorrow
      expect(SetRider.rider_joined_between?(user.id, min, max)).to be false
    end

    it 'is true when a rider has joined a set between yesterday and tommorrow' do
      set = WakeboardSet.create(scheduled_date: DateTime.tomorrow, driver_count: 1)
      set.join(user.id, true)
      min = DateTime.yesterday
      max = DateTime.tomorrow
      expect(SetRider.rider_joined_between?(user.id, min, max)).to be true
    end

    it 'is false when a rider has joined a set but range max is yesterday' do
      set = WakeboardSet.create(scheduled_date: DateTime.tomorrow, driver_count: 1)
      set.join(user.id, true)
      min = DateTime.yesterday.yesterday
      max = DateTime.yesterday
      expect(SetRider.rider_joined_between?(user.id, min, max)).to be false
    end

  end
end
