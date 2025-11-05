# frozen_string_literal: true

require 'application_system_test_case'

class BooksTest < ApplicationSystemTestCase
  def login_as_testuser
    visit root_url
    fill_in 'Eメール', with: 'test_user@example.com'
    fill_in 'パスワード', with: 'password'

    click_button 'ログイン'
    assert_text 'ログインしました。'

    visit books_url
    assert_selector 'h1', text: '本の一覧'
  end

  def fill_in_book_information
    fill_in 'タイトル', with: '吾輩は猫である'
    fill_in 'メモ', with: '吾輩わがはいは猫である。'
    fill_in '著者', with: '夏目漱石'
    attach_file 'book[picture]', Rails.root.join('test/fixtures/files/cat.png')
  end

  def check_book_information
    assert_text '吾輩は猫である'
    assert_text '吾輩わがはいは猫である。'
    assert_text '夏目漱石'
    assert_selector "img[src*='cat.png']"
  end

  test 'ログインして本を新規作成' do
    login_as_testuser
    click_on '本の新規作成'
    fill_in_book_information
    click_button '登録する'

    assert_text '本が作成されました。'
    visit book_url(Book.last)
    check_book_information
  end

  test '本の編集' do
    login_as_testuser
    click_on 'この本を表示'
    click_on 'この本を編集'
    fill_in_book_information
    click_button '更新する'

    assert_text '本が更新されました。'
    visit book_url(Book.last)
    check_book_information
  end

  test '本の削除' do
    login_as_testuser
    click_on 'この本を表示'
    click_button 'この本を削除'

    assert_text '本が削除されました。'
    visit books_url
    assert_no_text '山月記'
    assert_no_text '隴西ろうさいの李徴りちょうは博学才穎さいえい、'
    assert_no_text '中島敦'
  end
end
