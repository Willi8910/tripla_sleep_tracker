require 'rails_helper'

RSpec.describe ClockOutController, type: :controller do
  let(:user) { create(:user) }
  let(:clock_in_time) { 8.hours.ago }
  let!(:sleep_record) { create(:sleep_record, user: user, clock_in: clock_in_time, clock_out: nil) }

  before do
    request.headers['X-User-Id'] = user.id.to_s
  end

  describe 'POST #create' do
    context 'when user is authenticated' do
      context 'when clock-out is successful' do
        it 'updates the sleep record with clock_out' do
          post :create

          expect(response).to have_http_status(:ok)
          expect(sleep_record.reload.clock_out).to be_truthy
        end
      end

      context 'when there is no active clock-in record' do
        before { sleep_record.update(clock_out: Time.current) }

        it 'returns an error response' do
          post :create

          expect(response).to have_http_status(:unprocessable_entity)
          json_response = JSON.parse(response.body)
          expect(json_response['error']).to include('No active clock-in record found.')
        end
      end

      context 'when updating the sleep record fails' do
        before do
          allow_any_instance_of(SleepRecord).to receive(:save).and_return(false)
          allow_any_instance_of(SleepRecord).to receive(:errors).and_return(double(full_messages: ['Clock-out failed']))
        end

        it 'returns error messages' do
          post :create

          expect(response).to have_http_status(:unprocessable_entity)
          json_response = JSON.parse(response.body)
          expect(json_response['error']).to include('Clock-out failed')
        end
      end
    end

    context 'when user is not authenticated' do
      before { request.headers['X-User-Id'] = nil }

      it 'returns an unauthorized response' do
        post :create

        expect(response).to have_http_status(:unauthorized)
        json_response = JSON.parse(response.body)
        expect(json_response['error']).to include('Unauthorized')
      end
    end
  end
end
