# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  it 'is valid with a name' do
    user = User.new(name: 'Test User')
    expect(user).to be_valid
  end

  it 'is invalid without a name' do
    user = User.new(name: nil)
    expect(user).to_not be_valid
    expect(user.errors[:name]).to include("can't be blank")
  end
end