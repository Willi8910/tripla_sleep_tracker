# frozen_string_literal: true

class CreateSleepRecordTable < ActiveRecord::Migration[7.1]
  def change
    create_table :sleep_records, id: :uuid do |t|
      t.references :user, type: :uuid, null: false, foreign_key: true
      t.datetime :clock_in, null: false
      t.datetime :clock_out
      t.interval :duration
      t.timestamps
    end
  end
end
