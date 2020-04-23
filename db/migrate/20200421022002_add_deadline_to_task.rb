class AddDeadlineToTask < ActiveRecord::Migration[5.2]
  def up
    add_column :tasks, :deadline, :date, null: false, default: '2020-04-21'
    change_column_default :tasks, :deadline, nil
  end
end
