# frozen_string_literal: true

users = 5.times.map do |i|
  User.create!(name: "User #{i + 1}")
end

users.each do |user|
  # Each user follows 2-3 other users (excluding themselves)
  following_users = users.reject { |u| u == user }.sample(rand(2..3))
  following_users.each do |following_user|
    FollowingUser.create!(user: user, following_user: following_user)
  end
end

users.each do |user|
  3.times do |i|
    clock_in_time = rand(1..7).days.ago
    clock_out_time = clock_in_time + rand(1..8).hours
    SleepRecord.create!(
      user: user,
      clock_in: clock_in_time,
      clock_out: clock_out_time,
      duration: clock_out_time - clock_in_time
    )
  end
end

puts "Seed data created successfully."
