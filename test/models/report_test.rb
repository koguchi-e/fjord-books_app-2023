# frozen_string_literal: true

require 'test_helper'

class ReportTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test 'ユーザーが一致する時、editable?がtrueを返すか' do
    user = User.new(name: '山田太郎', email: 'yamada@example.com')
    report = Report.new(title: '１日目', content: 'テストを書くのは難しい', user: user)
    assert report.editable?(user)
  end

  test 'created_onが日付を返すか' do
    now = Time.current
    report = Report.new(title: '１日目', content: 'テストを書くのは難しい', created_at: now)
    assert_equal now.to_date, report.created_on
    assert_instance_of Date, report.created_on
  end
end
