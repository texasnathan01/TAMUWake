# # location: spec/unit/role_unit_spec.rb
# require 'rails_helper'

# RSpec.describe Role, type: :model do
#   subject do
#     described_class.new(role_id: 1 ,role_name: 'team')
#   end

#   it 'is valid with valid attributes' do
#     expect(subject).to be_valid
#   end

#   it 'is not valid without a role_id' do
#     subject.role_id = nil
#     expect(subject).not_to be_valid
#   end

#   it 'is not valid without a role_name' do
#     subject.role_name = nil
#     expect(subject).not_to be_valid
#   end

#   it 'is not valid without a negative role_id' do
#     subject.role_id = -1
#     expect(subject).not_to be_valid
#   end

# end