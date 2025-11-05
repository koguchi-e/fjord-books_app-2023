# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'name_or_emailが名前を返すか' do
    user = users(:user)
    assert_equal 'テストユーザー', user.name_or_email
  end

  test 'name_or_emailがもし名前が空欄ならメールアドレスを返すか' do
    user = User.new(name: '', email: 'yamada@example.com')
    assert_equal 'yamada@example.com', user.name_or_email
  end
end
