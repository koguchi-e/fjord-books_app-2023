# frozen_string_literal: true

# queue_adapterを変更している理由とtransactionを使っている理由は下記URLを参照
# https://bootcamp.fjord.jp/questions/779#answer_2262
ActiveStorage::AnalyzeJob.queue_adapter = :inline

print '開発環境のデータをすべて削除して初期データを投入します。よろしいですか？[Y/n]: ' # rubocop:disable Rails/Output
unless $stdin.gets.chomp.casecmp('Y').zero?
  puts '中止しました。' # rubocop:disable Rails/Output
  return
end

def picture_file(name)
  File.open(Rails.root.join("db/seeds/#{name}"))
end

def add_comments_to(commentable, contents)
  comment_count = [*0..3].sample
  times = Array.new(3) do
    Faker::Time.between(from: commentable.created_at.since(10.minutes), to: commentable.created_at.since(2.days))
  end.sort
  users = User.all.to_a
  comment_count.times do |n|
    time = times[n]
    user = users.sample
    content = contents.sample
    commentable.comments.create!(user:, content:, created_at: time, updated_at: time)
  end
end

puts '実行中です。しばらくお待ちください...' # rubocop:disable Rails/Output

Book.destroy_all

Book.transaction do # rubocop:disable Metrics/BlockLength
  Book.create!(
    title: 'Ruby超入門',
    memo: 'Rubyの文法の基本をやさしくていねいに解説しています。',
    author: '五十嵐 邦明',
    picture: picture_file('cho-nyumon.jpg')
  )

  Book.create!(
    title: 'チェリー本',
    memo: 'プログラミング経験者のためのRuby入門書です。',
    author: '伊藤 淳一',
    picture: picture_file('cherry-book.jpg')
  )

  Book.create!(
    title: '楽々ERDレッスン',
    memo: '実在する帳票から本当に使えるテーブル設計を導く画期的な本！',
    author: '羽生 章洋',
    picture: picture_file('erd.jpg')
  )

  50.times do
    Book.create!(
      title: Faker::Book.title,
      memo: Faker::Book.genre,
      author: Faker::Book.author,
      picture: picture_file('no-image.png')
    )
  end
end

User.destroy_all

User.transaction do
  50.times do |n|
    name = Faker::Name.name
    User.create!(
      email: "sample-#{n}@example.com",
      password: 'password',
      name:,
      postal_code: "123-#{n.to_s.rjust(4, '0')}",
      address: Faker::Address.full_address,
      self_introduction: "こんにちは、#{name}です。"
    )
  end
end

# 画像は読み込みに時間がかかるので一部のデータだけにする
User.order(:id).each.with_index(1) do |user, n|
  next unless (n % 8).zero?

  number = rand(1..6)
  image_path = Rails.root.join("db/seeds/avatar-#{number}.png")
  user.avatar.attach(io: File.open(image_path), filename: 'avatar.png')
end

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

puts '初期データの投入が完了しました。' # rubocop:disable Rails/Output
