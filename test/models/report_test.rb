# frozen_string_literal: true

require 'test_helper'

class ReportTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test 'ユーザーが一致する時、editable?がtrueを返すか' do
    user = users(:user)
    report = reports(:report)
    assert report.editable?(user)
  end

  test 'created_onが日付を返すか' do
    report = reports(:report)
    assert_equal report.created_at.to_date, report.created_on
    assert_instance_of Date, report.created_on
  end

  test 'レポートに含まれるURLからmentioned_reportsが正しく作成されるか' do
    report = reports(:report)
    report.mentioned_reports.each do |m|
      assert_equal 1, m.id
    end
  end
end
