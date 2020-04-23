100.times do |i|
  Task.create!(
    task_name: "#{i}番目のタスク",
    description: "#{i}番目のブログの内容",
    deadline: Date.today,
    status: "未着手",
    rank: 0
  )
end
