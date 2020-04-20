FactoryBot.define do
  factory :task do
    task_name { 'test_name1' }
    description { 'test_description1' }
  end

  factory :second_task, class: Task do
    task_name { 'test_name2' }
    description { 'test_description2' }
  end

  factory :third_task, class: Task do
    task_name { 'test_name3' }
    description { 'test_description3' }
  end
end
