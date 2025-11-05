FactoryBot.define do
  factory :user do
    name {'テストユーザー'}
    sequence(:email) { |n| 'test_user{n}@example.com' }
    password {'password'}
  end
end
