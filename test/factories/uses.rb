# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { 'テストユーザー' }
    sequence(:email) { 'test_user{n}@example.com' }
    password { 'password' }
  end
end
