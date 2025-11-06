# frozen_string_literal: true

FactoryBot.define do
  factory :report do
    title { '1日目' }
    content { 'http://localhost:3000/reports/1' }
    created_at { Time.current }
    association :user
  end
end
