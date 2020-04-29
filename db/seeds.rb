# ユーザー作成
5.times do |n|
  User.create(
    name: "test_admin_#{n + 1}",
    email: "test_admin_#{n + 1}@gmail.com",
    password: "0000000",
    password_confirmation: "0000000",
    admin: true
  )
end

5.times do |n|
  User.create(
    name: "test_user_#{n + 1}",
    email: "test_user_#{n + 1}@gmail.com",
    password: "0000000",
    password_confirmation: "0000000",
    admin: false
  )
end

#task作成
User.all.each do |user|
  5.times do |i|
    user.tasks.create(
      task_name: "#{i}番目のタスク",
      description: "#{i}番目のタスクの内容",
      deadline: Date.today.change(day: i+1),
      status: "未着手",
      rank: 0,
      user_id: user.id
    )
  end
end

User.all.each do |user|
  5.times do |i|
    user.tasks.create(
      task_name: "#{i}番目のタスク",
      description: "#{i}番目のタスクの内容",
      deadline: Date.today.change(day: i+2),
      status: "着手中",
      rank: 1,
      user_id: user.id
    )
  end
end

User.all.each do |user|
  5.times do |i|
    user.tasks.create(
      task_name: "#{i}番目のタスク",
      description: "#{i}番目のタスクの内容",
      deadline: Date.today.change(day: i+3),
      status: "完了",
      rank: 2,
      user_id: user.id
    )
  end
end

#label作成
Label.create([
               {title: "work"},
               {title: "private"},
               {title: "other"}
             ])

#taskとlabelの紐付け
Task.all.sample(50).each do |task|
  label = Label.first
  task.task_to_labels.create(task_id: task.id, label_id: label.id)
end

Task.all.sample(50).each do |task|
  label = Label.second
  task.task_to_labels.create(task_id: task.id, label_id: label.id)
end

Task.all.sample(50).each do |task|
  label = Label.third
  task.task_to_labels.create(task_id: task.id, label_id: label.id)
end