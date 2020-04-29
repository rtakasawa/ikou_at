class AddIndexToTitle < ActiveRecord::Migration[5.2]
  def up
    add_index :labels, :title, unique: true
  end
  def down
    remove_index :labels, column: :title
  end
end
