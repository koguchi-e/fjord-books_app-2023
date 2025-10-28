# frozen_string_literal: true

user1 = User.create!(
  email: 'test1@example.com',
  password: '123456',
  password_confirmation: '123456',
  name: 'テスト太郎'
)

user2 = User.create!(
  email: 'test2@example.com',
  password: '123456',
  password_confirmation: '123456',
  name: 'テスト花子'
)

report1 = Report.create!(
  title: '1日目・晴れ',
  content: 'こんにちは',
  user: user1
)

report2 = Report.create!(
  title: '2日目：曇り',
  content: 'おはようございます',
  user: user2
)

report3 = Report.create!(
  title: '言及テスト1',
  content: "言及しているものが複数あり・重複している場合：
  http://127.0.0.1:3000/reports/#{report1.id}
  http://127.0.0.1:3000/reports/#{report1.id}
  http://127.0.0.1:3000/reports/#{report2.id}",
  user: user1
)

report4 = Report.create!(
  title: '言及テスト2',
  content: "言及テスト1を言及している：http://127.0.0.1:3000/reports/#{report3.id}",
  user: user2
)

Comment.create!(
  content: 'よく頑張りましたね！',
  user: user2,
  commentable: report3
)

Comment.create!(
  content: 'ありがとうございます！',
  user: user1,
  commentable: report3
)

Comment.create!(
  content: 'おはよう',
  user: user1,
  commentable: report4
)
