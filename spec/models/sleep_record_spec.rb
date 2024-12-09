# frozen_string_literal: true

# == Schema Information
#
# Table name: sleep_records
#
#  id         :uuid             not null, primary key
#  clock_in   :datetime         not null
#  clock_out  :datetime
#  duration   :interval
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :uuid             not null
#
# Indexes
#
#  index_sleep_records_on_created_at  (created_at)
#  index_sleep_records_on_duration    (duration)
#  index_sleep_records_on_user_id     (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe SleepRecord, type: :model do
  let(:user) { User.create!(name: 'User A') }

  it 'is valid with valid attributes' do
    record = SleepRecord.new(user:, clock_in: Time.now - 8.hours, clock_out: Time.now)
    expect(record).to be_valid
  end

  it 'is invalid without clock_in' do
    record = SleepRecord.new(user:, clock_in: nil)
    expect(record).not_to be_valid
  end

  it 'calculates duration when clock_out is set' do
    clock_in = Time.now - 8.hours
    clock_out = Time.now
    record = SleepRecord.create!(user:, clock_in:, clock_out:)
    expect(record.duration).to eq(clock_out - clock_in)
  end

  it 'validates that clock_out is after clock_in' do
    record = SleepRecord.new(user:, clock_in: Time.now, clock_out: Time.now - 1.hour)
    expect(record).not_to be_valid
    expect(record.errors[:clock_out]).to include('must be after clock_in')
  end
end
