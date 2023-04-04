# require 'rails_helper'

# RSpec.describe WakeboardSet, type: :model do
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
# end