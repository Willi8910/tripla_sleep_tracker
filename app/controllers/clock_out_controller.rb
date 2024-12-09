# frozen_string_literal: true

class ClockOutController < ApplicationController
  before_action :authenticate_user!

  def create
    result = SleepRecordCommands::ClockOutRecord.new(current_user).perform

    if result[:success].present?
      sleep_record_params = {
        sort_by: :created_at,
        sort_oder: :desc,
        user_ids: current_user.id
      }
      sleep_records = SleepRecordCommands::QuerySleepRecords.new(current_user, sleep_record_params).perform
      render json: sleep_records, each_serializer: SleepRecordSerializer, status: :ok
    else
      render_failed(result[:error])
    end
  end
end
