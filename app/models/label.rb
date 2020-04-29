class Label < ApplicationRecord
  validates :title, uniqueness: true
  has_many :task_to_labels, dependent: :destroy
  has_many :tasks, through: :task_to_labels
end