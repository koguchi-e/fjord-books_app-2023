# frozen_string_literal: true

FactoryBot.define do
  factory :report do
    title { '1日目' }
    content { 'オブジェクト指向が難しかったです。' }
    created_at { Time.current }
    user
  end
end
