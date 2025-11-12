# frozen_string_literal: true

require 'test_helper'

class ReportTest < ActiveSupport::TestCase
  test 'ユーザーが一致する時、editable?がtrueを返すか' do
    user = create(:user)
    report = create(:report, user: user)
    assert report.editable?(user)
  end

  test 'created_onが日付を返すか' do
    report = create(:report, created_at: Time.zone.local(2025, 11, 01))
    assert_equal Date.new(2025, 11, 01), report.created_on
  end

  def create_mention_lists
    @user = create(:user)
    @mentioned = create(:report, user: @user)
    @report = create(:report, user: @user, content: "http://localhost:3000/reports/#{@mentioned.id}")
  end

  test 'レポートに含まれるURLからmentioning_reportsが正しく作成されるか' do
    create_mention_lists
    assert_includes @report.mentioning_reports, @mentioned
  end

  test '言及の編集のテスト' do
    create_mention_lists
    mentioned2 = create(:report, user: @user)
    @report.update(content: "http://localhost:3000/reports/#{mentioned2.id}")
    assert_not_equal @report.mentioned_reports, @mentioned
    assert_includes @report.mentioning_reports, mentioned2
  end

  test '言及の削除のテスト' do
    create_mention_lists
    @mentioned.destroy
    assert_not_equal @report.mentioned_reports, @mentioned
  end
end
