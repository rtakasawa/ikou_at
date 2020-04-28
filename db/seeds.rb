# 100.times do |i|
#   Task.create!(
#     task_name: "#{i}番目のタスク",
#     description: "#{i}番目のブログの内容",
#     deadline: Date.today,
#     status: "未着手",
#     rank: 0
#   )
# end

# User.create(name: "a@gmail.com", email: "a@gmail.com", password: "a@gmail.com", password_confirmation: "a@gmail.com")

Task.create(
    task_name: "テストタスク",
    description: "テストブログの内容",
    deadline: Date.today,
    status: "未着手",
    rank: 0,
    user_id: 4
)