# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let!(:user) { create(:user) }
  let!(:following_user) { create(:user) }
  let!(:following_user2) { create(:user) }
  let!(:non_following_user) { create(:user) }

  before do
    request.headers['X-User-Id'] = user.id.to_s
    user.following_users.create(following_user:)
    user.following_users.create(following_user: following_user2)
    create(:sleep_record, user: following_user, clock_in: 2.days.ago, clock_out: 1.day.ago)
    create(:sleep_record, user: following_user2, clock_in: 5.days.ago, clock_out: 3.days.ago)
    create(:sleep_record, user: non_following_user, clock_in: 4.days.ago, clock_out: 1.day.ago)
  end

  describe 'GET #following_user_sleep_records' do
    it 'returns sleep records of following users from the last week, sorted by duration' do
      get :following_user_sleep_records
      expect(response).to have_http_status(:ok)

      json_response = JSON.parse(response.body)
      expect(json_response.size).to eq(2)

      expect(json_response.first['sleep_record']['duration']).to eq(172_800)
      expect(json_response.first['user']['id']).to eq(following_user2.id)

      expect(json_response.last['sleep_record']['duration']).to eq(86_400)
      expect(json_response.last['user']['id']).to eq(following_user.id)
    end
  end
end
