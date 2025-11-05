# frozen_string_literal: true

require 'application_system_test_case'

class BooksTest < ApplicationSystemTestCase
  def create_book
    click_on '本の新規作成'
    fill_in 'タイトル', with: '吾輩は猫である'
    fill_in 'メモ', with: '吾輩わがはいは猫である。'
    fill_in '著者', with: '夏目漱石'
    attach_file 'book[picture]', Rails.root.join('test/fixtures/files/cat.png')

    click_button '登録する'
    assert_text '本が作成されました。'
  end

  test 'ログインして本を新規作成' do
    login_as_testuser
    create_book

    visit book_url(Book.last)
    assert_text '吾輩は猫である'
    assert_text '吾輩わがはいは猫である。'
    assert_text '夏目漱石'
    assert_selector "img[src*='cat.png']"
  end

  test '本の編集' do
    login_as_testuser
    create_book
    visit books_url
    click_on 'この本を表示'
    click_on 'この本を編集'

    fill_in 'タイトル', with: '吾輩は猫である2'
    fill_in 'メモ', with: '続編'
    fill_in '著者', with: '夏目漱石2世'
    attach_file 'book[picture]', Rails.root.join('test/fixtures/files/girl.png')
    click_button '更新する'

    assert_text '本が更新されました。'
    visit book_url(Book.last)
    assert_text '吾輩は猫である2'
    assert_text '続編'
    assert_text '夏目漱石2世'
    assert_selector "img[src*='girl.png']"
  end

  test '本の削除' do
    login_as_testuser
    create_book
    visit books_url
    click_on 'この本を表示'
    click_button 'この本を削除'

    assert_text '本が削除されました。'
    visit books_url
    assert_no_text '吾輩は猫である'
    assert_no_text '吾輩わがはいは猫である。'
    assert_no_text '夏目漱石'
  end
end
