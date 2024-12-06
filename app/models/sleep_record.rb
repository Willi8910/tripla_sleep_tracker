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
class SleepRecord < ApplicationRecord
  belongs_to :user

  validates :clock_in, presence: true
  validate :clock_out_after_clock_in, if: -> { clock_out.present? }

  before_save :calculate_duration

  private

  def clock_out_after_clock_in
    errors.add(:clock_out, 'must be after clock_in') if clock_out <= clock_in
  end

  def calculate_duration
    return unless clock_in.present? && clock_out.present?

    self.duration = clock_out - clock_in
  end
end
