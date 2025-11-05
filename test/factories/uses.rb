FactoryBot.define do
  factory :user do
    name {'テストユーザー'}
    email {'test_user@example.com'}
    password {'password'}
  end
end
