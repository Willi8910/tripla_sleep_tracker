# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    id { Faker::Internet.uuid }
    name { Faker::Internet.name }
  end
end
