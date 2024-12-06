# frozen_string_literal: true

class SleepRecordSerializer < ActiveModel::Serializer
  attributes :id, :clock_in, :clock_out, :duration, :created_at, :updated_at
end
