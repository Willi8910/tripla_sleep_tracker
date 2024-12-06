# frozen_string_literal: true

class AddIndexToSleepRecordDuration < ActiveRecord::Migration[7.1]
  def change
    add_index :sleep_records, :duration, using: :btree
  end
end
