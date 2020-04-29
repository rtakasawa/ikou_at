FactoryBot.define do
  factory :label do
    title { "test_label_1" }
  end

  factory :second_label, class: Label do
    title { "test_label_2" }
  end
end
