User.create!(
  name: 'takashi07',
  email: 'takashi07@sample.ne',
  password: "takashi07",
  password_confirmation: "takashi07",
  admin: true
)

10.times do |n|
  User.create!(
    name: "テスト#{n + 1}",
    email: "test#{n + 1}@test.com",
    password: "testtest#{n + 1}",
    password_confirmation: "testtest#{n + 1}",
    admin: false
  )
end

10.times do |n|
  Task.create!(
    name: "title#{n + 1}",
    content: "content#{n + 1}",
    deadline: "2023-03-18",
    status: "未着手",
    priority: "高",
    user_id: n + 1
  )
end

5.times do |i|
  Label.create!(label_name: "sample#{i + 1}")
end

