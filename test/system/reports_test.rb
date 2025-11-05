# frozen_string_literal: true

require 'application_system_test_case'

class ReportsTest < ApplicationSystemTestCase
  # setup do
  #   @report = reports(:one)
  # end

  fixtures :users

  def login_as_testuser
    visit root_url
    fill_in 'Eメール', with: 'test_user@example.com'
    fill_in 'パスワード', with: 'password'

    click_button 'ログイン'
    assert_text 'ログインしました。'

    visit books_url
    assert_selector 'h1', text: '本の一覧'
    click_on '日報'

    visit reports_url
    assert_selector 'h1', text: '日報の一覧'
  end

  test 'ログインして新規に日報を作成する' do
    login_as_testuser

    click_on '日報の新規作成'
    fill_in 'タイトル', with: '2日目'
    fill_in '内容', with: 'テストコードは楽しい、設計が苦手だと気づく'
    click_button '登録する'
    assert_text '日報が作成されました。'

    visit report_url(Report.last)
    assert_text '2日目'
    assert_text 'テストコードは楽しい、設計が苦手だと気づく'
  end

  test '日報の編集' do
    login_as_testuser
    sleep 3
    click_on 'この日報を表示'

    click_on 'この日報を編集'
    fill_in 'タイトル', with: '3日目'
    fill_in '内容', with: 'RubyGoldが難しい！'

    click_button '更新する'
    assert_text '日報が更新されました。'

    visit report_url(Report.last)
    assert_text '3日目'
    assert_text 'RubyGoldが難しい！'
  end

  test '日報の削除' do
    login_as_testuser
    click_on 'この日報を表示'

    click_button 'この日報を削除'
    assert_text '日報が削除されました。'
    visit reports_url
    assert_no_text '１日目'
    assert_no_text 'http://localhost:3000/reports/1'
  end

  # test 'visiting the index' do
  #   visit reports_url
  #   assert_selector 'h1', text: 'Reports'
  # end

  # test 'should create report' do
  #   visit reports_url
  #   click_on 'New report'

  #   fill_in 'Content', with: @report.content
  #   fill_in 'Title', with: @report.title
  #   fill_in 'User', with: @report.user_id
  #   click_on 'Create Report'

  #   assert_text 'Report was successfully created'
  #   click_on 'Back'
  # end

  # test 'should update Report' do
  #   visit report_url(@report)
  #   click_on 'Edit this report', match: :first

  #   fill_in 'Content', with: @report.content
  #   fill_in 'Title', with: @report.title
  #   fill_in 'User', with: @report.user_id
  #   click_on 'Update Report'

  #   assert_text 'Report was successfully updated'
  #   click_on 'Back'
  # end

  # test 'should destroy Report' do
  #   visit report_url(@report)
  #   click_on 'Destroy this report', match: :first

  #   assert_text 'Report was successfully destroyed'
  # end
end
