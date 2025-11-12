# frozen_string_literal: true

FactoryBot.define do
  factory :report do
    title { '1日目' }
    content { 'オブジェクト指向が難しかったです。' }
    created_at { Time.new(2025, 11, 01) }
    user
  end
end
