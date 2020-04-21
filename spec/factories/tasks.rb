FactoryBot.define do
  factory :task do
    task_name { 'test_name1' }
    description { 'test_description1' }
    deadline { '1900-01-01' }
  end

  factory :second_task, class: Task do
    task_name { 'test_name2' }
    description { 'test_description2' }
    deadline { '2000-01-01' }
  end

  factory :third_task, class: Task do
    task_name { 'test_name3' }
    description { 'test_description3' }
    deadline { '2100-01-01' }
  end
end
