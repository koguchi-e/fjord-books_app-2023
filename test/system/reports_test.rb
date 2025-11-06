# frozen_string_literal: true

require 'application_system_test_case'

class ReportsTest < ApplicationSystemTestCase
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

  test 'ログインして新規に日報を作成する' do
    login_as_testuser
    create_report

    visit report_url(Report.last)
    assert_text '2日目'
    assert_text 'テストコードは楽しい、設計が苦手だと気づく'
  end

  test '日報の編集' do
    login_as_testuser
    create_report

    click_on '日報の一覧に戻る'
    visit reports_url
    assert_selector 'h1', text: '日報の一覧'

    click_on 'この日報を表示'

    click_on 'この日報を編集'
    fill_in 'タイトル', with: '3日目'
    fill_in '内容', with: '難しい'

    click_button '更新する'
    assert_text '日報が更新されました。'

    visit report_url(Report.last)
    assert_text '3日目'
    assert_text '難しい'
  end

  test '日報の削除' do
    login_as_testuser
    create_report

    click_on '日報の一覧に戻る'
    visit reports_url
    assert_selector 'h1', text: '日報の一覧'

    click_on 'この日報を表示'

    click_button 'この日報を削除'
    assert_text '日報が削除されました。'
    visit reports_url
    assert_no_text '2日目'
    assert_no_text 'テストコードは楽しい、設計が苦手だと気づく'
  end
end
