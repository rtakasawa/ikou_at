class Task < ApplicationRecord
  validates :task_name, presence: true
  validates :description, presence: true
  validates :deadline, presence: true

  scope :search_task_name, ->(task_name) {where("task_name LIKE ?", "%#{task_name}%")}
  scope :search_status, ->(status) {where(status: status)}

  enum rank:{ 低: 0, 中: 1, 高: 2 }
end
