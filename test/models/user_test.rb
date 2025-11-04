# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  
  test 'name_or_email return name if present' do
    user = User.new(name: '山田太郎', email: 'yamada@example.com')
    assert_equal '山田太郎', user.name_or_email
  end
  test 'name_or_email retrn email if name is blank' do
    user = User.new(name: '', email: 'yamada@example.com')
    assert_equal 'yamada@example.com', user.name_or_email
  end
end
