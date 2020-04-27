class Task < ApplicationRecord
  validates :task_name, presence: true
  validates :description, presence: true
  validates :deadline, presence: true

  belongs_to :user
  has_many :task_to_labels, dependent: :destroy
  has_many :labels, through: :task_to_labels

  scope :search_task_name, ->(task_name) {where("task_name LIKE ?", "%#{task_name}%")}
  scope :search_status, ->(status) {where(status: status)}

  enum rank:{ 低: 0, 中: 1, 高: 2 }

  paginates_per 10

end