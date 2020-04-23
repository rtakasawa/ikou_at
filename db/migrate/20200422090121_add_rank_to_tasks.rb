class AddRankToTasks < ActiveRecord::Migration[5.2]
  def up
    add_column :tasks, :rank, :integer, null: false, default: 0
    change_column_default :tasks, :rank, nil
  end
end
