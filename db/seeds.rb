# 5.times do |i|
#   TaskToLabel.create!(
#     task_id: i+150,
#     label_id: 3
#   )
# end
#
# 5.times do |i|
#   TaskToLabel.create!(
#     task_id: i+155,
#     label_id: 4
#   )
# end
#
# 5.times do |i|
#   TaskToLabel.create!(
#     task_id: i+160,
#     label_id: 5
#   )
# end

# 20.times do |i|
#   Task.create!(
#     task_name: "c#{i}番目のタスク",
#     description: "#{i}番目のブログの内容",
#     deadline: Date.today,
#     status: "未着手",
#     rank: 0,
#     user_id: 21
#   )
# end

# User.create(name: "a@gmail.com", email: "a@gmail.com", password: "a@gmail.com", password_confirmation: "a@gmail.com", admin: true )
# User.create(name: "b@gmail.com", email: "b@gmail.com", password: "b@gmail.com", password_confirmation: "b@gmail.com", admin: false )
# User.create(name: "c@gmail.com", email: "c@gmail.com", password: "c@gmail.com", password_confirmation: "c@gmail.com", admin: false )

# Label.create([
#                {title: "work"},
#                {title: "private"},
#                {title: "other"}
#              ])