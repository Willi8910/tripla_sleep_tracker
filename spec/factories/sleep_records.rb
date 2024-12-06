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
#  index_sleep_records_on_duration  (duration)
#  index_sleep_records_on_user_id   (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
FactoryBot.define do
  factory :sleep_record do
    association :user
    clock_in { Time.now - 8.hours }
    clock_out { Time.now }
  end
end
