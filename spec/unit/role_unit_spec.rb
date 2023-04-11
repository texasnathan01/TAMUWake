# location: spec/unit/role_unit_spec.rb
require 'rails_helper'

RSpec.describe Role, type: :model do
  subject do
    described_class.new(id: 1 ,role_name: 'team')
  end

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end
  
end
