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
class SleepRecordSerializer < ActiveModel::Serializer
  attributes :id, :clock_in, :clock_out, :duration, :created_at, :updated_at
end
