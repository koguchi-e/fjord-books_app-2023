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
end
