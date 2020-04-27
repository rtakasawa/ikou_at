class Label < ApplicationRecord
  has_many :task_to_label, dependent: :destroy
  has_many :tasks, through: :task_to_labels
end
