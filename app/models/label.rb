class Label < ApplicationRecord
  has_many :task_to_labels, dependent: :destroy
  has_many :tasks, through: :task_to_labels
  validates :title, uniqueness: true
end