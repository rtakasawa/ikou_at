class ChangeColumnNullTasks < ActiveRecord::Migration[5.2]
  def change
    change_column :tasks,:description, :text, null: false
  end
end
