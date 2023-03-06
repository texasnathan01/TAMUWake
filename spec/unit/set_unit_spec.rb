require 'rails_helper'

RSpec.describe WakeboardSet, type: :model do
  subject do
    described_class.new(
      dib_count: 0,
      chib_count: 0,
      driver_count: 1,
      scheduled_date: (DateTime.current).tomorrow,
    )
  end

  before(:example) do
    expect(subject).to be_valid
  end

  it 'is valid with positive 0 dibs and chibs, date tomorrow, and driver count 1' do
    expect(subject).to be_valid
  end

  it 'is not valid for driver count = 0' do
    subject.driver_count = 0
    expect(subject).not_to be_valid
  end

  it 'is not valid for negative dib, chib, and driver limits' do
    subject.dib_limit = -1
    expect(subject).not_to be_valid

    subject.dib_limit = 4
    expect(subject).to be_valid

    subject.chib_limit = -1
    expect(subject).not_to be_valid

    subject.chib_limit = 3
    expect(subject).to be_valid

    subject.driver_limit = -1
    expect(subject).not_to be_valid
  end

  it 'is not valid for negative dib, chib, and driver counts' do
    subject.dib_count = -1
    expect(subject).not_to be_valid

    subject.dib_count = 0
    expect(subject).to be_valid

    subject.chib_count = -1
    expect(subject).not_to be_valid

    subject.chib_count = 0
    expect(subject).to be_valid

    subject.driver_count = -1
    expect(subject).not_to be_valid
  end

  it 'is not valid when current dib count is > dib limit' do
    subject.dib_limit = 2
    subject.dib_count = 3
    expect(subject.dib_count).to be > subject.dib_limit
    expect(subject).not_to be_valid
  end

  it 'is valid when current dib count is = dib limit' do
    subject.dib_limit = 3
    subject.dib_count = 3
    expect(subject.dib_count).to eq(subject.dib_limit)
    expect(subject).to be_valid
  end

  it 'is not valid when current chib count is > chib limit' do
    subject.chib_limit = 2
    subject.chib_count = 3
    expect(subject.chib_count).to be > subject.chib_limit
    expect(subject).not_to be_valid
  end

  it 'is valid when current chib count is = chib limit' do
    subject.chib_limit = 3
    subject.chib_count = 3
    expect(subject.chib_count).to eq(subject.chib_limit)
    expect(subject).to be_valid
  end

  it 'is not valid when scheduled date is in the past' do
    now = DateTime.current
    subject.scheduled_date = now.days_ago(1)
    expect(subject.scheduled_date.prev_day?).to be true
    expect(subject).not_to be_valid
  end
end