# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ClockInController, type: :controller do
  let!(:user) { create(:user) }
  let(:headers) { { 'X-User-Id' => user.id.to_s } }

  describe 'POST #create' do
    context 'when user is authenticated' do
      before do
        request.headers.merge!(headers)
        create(:sleep_record, user: user, clock_in: Time.current - 1.day)
      end

      it 'creates a new sleep record and returns the list of all clocked-in records' do
        post :create
        expect(response).to have_http_status(:created)

        json_response = JSON.parse(response.body)
        expect(json_response).to be_an_instance_of(Array)
        expect(json_response.size).to be > 1

        initial_record = SleepRecord.find_by(user: user, clock_in: ..Time.current)
        expect(json_response.map { |record| record['id'] }).to include(initial_record.id)
      end
    end

    context 'when user is not authenticated' do
      it 'returns a 401 unauthorized status' do
        # No headers set here
        post :create
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe 'GET #index' do
    context 'when user is authenticated' do
      before do
        request.headers.merge!(headers)
        SleepRecord.create!(user: user, clock_in: Time.current - 3.days, clock_out: nil, duration: nil)
        SleepRecord.create!(user: user, clock_in: Time.current - 2.days, clock_out: nil, duration: nil)
        SleepRecord.create!(user: user, clock_in: Time.current - 1.day, clock_out: nil, duration: nil)
      end

      it 'returns all clocked-in records, ordered by created_at' do
        get :index
        expect(response).to have_http_status(:ok)
        json_response = JSON.parse(response.body)
        expect(json_response.size).to eq(3)
        expect(json_response.map { |record| record['created_at'] }).to eq(
          json_response.map { |record| record['created_at'] }.sort.reverse
        )
      end
    end

    context 'when user is not authenticated' do
      it 'returns a 401 unauthorized status' do
        # No headers set here
        get :index
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
