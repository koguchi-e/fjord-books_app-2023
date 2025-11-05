# frozen_string_literal: true

require 'test_helper'

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :selenium, using: :chrome, screen_size: [1400, 1400] do |options|
    options.add_argument('--disable-gpu')
    options.add_preference('profile.password_manager_leak_detection', false)
  end

  include FactoryBot::Syntax::Methods
  def login_as_testuser
    user = create(:user)
    visit root_url
    fill_in 'Eメール', with: user.email
    fill_in 'パスワード', with: 'password'

    click_button 'ログイン'
    assert_text 'ログインしました。'

    visit books_url
    assert_selector 'h1', text: '本の一覧'
    user
  end
end
