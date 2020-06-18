class Task < ApplicationRecord
  belongs_to :user
  has_many :task_to_labels, dependent: :destroy
  has_many :labels, through: :task_to_labels

  validates :task_name, presence: true
  validates :description, presence: true
  validates :deadline, presence: true

  enum rank:{ 低: 0, 中: 1, 高: 2 }

  paginates_per 10

  scope :search, -> (search_params) do
    return if search_params.blank?

    search_task_name(search_params[:task_name])
      .search_status(search_params[:status])
      .search_label(search_params[:label_id])
  end

  scope :search_task_name, ->(task_name) {where("task_name LIKE ?", "%#{task_name}%") if task_name.present? }
  scope :search_status, ->(status) {where(status: status) if status.present? }
  scope :search_label, ->(label_id) do
    if label_id.present?
      task_id = TaskToLabel.all.search_label_id(label_id).pluck(:task_id)
      where(id: task_id )
    end
  end
end