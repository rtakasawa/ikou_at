class TaskToLabel < ApplicationRecord
  belongs_to :task
  belongs_to :label
  scope :search_label_id, ->(label_id) {where(label_id: label_id)}
end