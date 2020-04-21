class AddStatusToTask < ActiveRecord::Migration[5.2]
  def up
    add_column :tasks, :status, :string, null: false, default: "未着手"
    change_column_default :tasks, :status, nil
  end
end
