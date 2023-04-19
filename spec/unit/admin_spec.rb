# location: spec/unit/admin_spec.rb
require 'rails_helper'

RSpec.describe Admin, type: :model do
  subject do
    described_class.new(email: "chrispasala@tamu.edu" ,first_name: 'Chris',last_name: 'Pasala')
  end

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  it 'is valid with when attributes changed' do
    subject.first_name = "Axel"
    expect(subject).to be_valid
  end

  describe 'role helper methods - rider_can_join' do
    before :each do
      @user = Admin.find_or_create_by(email: "aramone@tamu.edu")
      @set = WakeboardSet.create(
        dib_count: 0,
        chib_count: 0,
        driver_count: 1,
        scheduled_date: (DateTime.current).tomorrow
      )
    end

end
