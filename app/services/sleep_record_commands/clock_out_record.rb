# frozen_string_literal: true

module SleepRecordCommands
  class ClockOutRecord
    def initialize(user)
      @user = user
    end

    def perform
      sleep_record = @user.sleep_records.where(clock_out: nil).order(:clock_in).last

      return { error: 'No active clock-in record found.' } if sleep_record.nil?

      sleep_record.update(clock_out: Time.current)

      return { error: sleep_record.errors.full_messages } unless sleep_record.save

      {
        success: 'Succesfully Clock out record',
        record: sleep_record
      }
    end
  end
end
