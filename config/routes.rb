# frozen_string_literal: true

Rails.application.routes.draw do
  get 'up' => 'rails/health#show', as: :rails_health_check

  resources :clock_in, only: %i[create index]
  resources :users, only: [] do
    member do
      post 'follow'
      delete 'unfollow'
    end
    collection do
      get 'following_user_sleep_records'
    end
  end
end
