# frozen_string_literal: true

require 'test_helper'

class ReportTest < ActiveSupport::TestCase
  test 'ユーザーが一致する時、editable?がtrueを返すか' do
    user = create(:user)
    report = create(:report, user: user)
    assert report.editable?(user)
  end

  test 'created_onが日付を返すか' do
    report = create(:report, created_at: Time.new(2025, 11, 01))
    assert_equal Date.new(2025, 11, 01), report.created_on
  end

  test 'レポートに含まれるURLからmentioning_reportsが正しく作成されるか' do
    user = create(:user)
    mentioned = create(:report, user: user)
    report = create(:report, user: user, content: "http://localhost:3000/reports/#{mentioned.id}")
    assert_includes report.mentioning_reports, mentioned
  end
end
