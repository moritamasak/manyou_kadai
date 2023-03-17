# 0.upto(9) do |idx|
#   User.create(
#     name: names[idx],
#     email: "#{names[idx]}@example.com",
#     password: 'password',
#     admin: true
#   )
# end

# 0.upto(9) do |idx|
#   Task.create(
#     title: "test#{idx + 1}",
#     content: "test#{idx +1}_content",
#     deadline: "2023/03/25",
#     status: '未着手',
#     priority: '中',
#     user_id: "1"
#   )
# end

5.times do |i|
  Label.create!(label_name: "sample#{i + 1}")
end