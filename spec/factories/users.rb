# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    first_name { "Test" }
    last_name { "Name" }
    sequence(:email) { |n| "test.name#{n}@example.com" }
    password_digest { BCrypt::Password.create("Password") }
  end
end
