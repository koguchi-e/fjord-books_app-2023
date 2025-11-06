# frozen_string_literal: true

require 'application_system_test_case'

class CommentsTest < ApplicationSystemTestCase
  def create_book
    click_on '本の新規作成'
    fill_in 'タイトル', with: '吾輩は猫である'
    fill_in 'メモ', with: '吾輩わがはいは猫である。'
    fill_in '著者', with: '夏目漱石'
    attach_file 'book[picture]', Rails.root.join('test/system/files/cat.png')

    click_button '登録する'
    assert_text '本が作成されました。'
  end

  def create_report
    click_on '日報'
    visit reports_url
    assert_selector 'h1', text: '日報の一覧'

    click_on '日報の新規作成'
    fill_in 'タイトル', with: '2日目'
    fill_in '内容', with: 'テストコードは楽しい、設計が苦手だと気づく'
    click_button '登録する'
    assert_text '日報が作成されました。'
  end

  def fill_in_comment
    fill_in 'comment[content]', with: 'こんにちは'
    click_button 'コメントする'
    assert_text 'コメントが作成されました。'
    assert_text 'こんにちは'
  end

  test '本にコメントを追加' do
    login_as_testuser
    create_book
    fill_in_comment
  end

  test '日報にコメントを追加' do
    login_as_testuser
    create_report
    fill_in_comment
  end

  test '本のコメントの削除' do
    login_as_testuser
    create_book
    fill_in_comment

    page.evaluate_script('window.confirm = function() { return true; }')
    click_button '削除'
    assert_text 'コメントが削除されました。'
    assert_no_text 'こんにちは'
  end

  test '日報のコメントの削除' do
    login_as_testuser
    create_report
    fill_in_comment

    page.evaluate_script('window.confirm = function() { return true; }')
    click_button '削除'
    assert_text 'コメントが削除されました。'
    assert_no_text 'こんにちは'
  end
end
