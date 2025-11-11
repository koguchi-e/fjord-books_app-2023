# frozen_string_literal: true

require 'test_helper'

class ReportTest < ActiveSupport::TestCase
  test 'ユーザーが一致する時、editable?がtrueを返すか' do
    user = create(:user)
    report = create(:report, :user)
    assert report.editable?(user)
  end

  test 'created_onが日付を返すか' do
    report = create(:report, created_at: Time.new(2025, 11, 01))
    assert_equal Date.new(2025, 11, 01), report.created_on
  end

  test 'レポートに含まれるURLからmentioned_reportsが正しく作成されるか' do
    report = create(:report, content: "http://localhost:3000/reports/1")
    report.mentioned_reports.each do |m|
      assert_equal 1, m.id
    end
  end
end
