require 'rails_helper'
Rspec.describe "タスク管理機能", type: :model do
  it "titleが空ならバリデーションが通らない" do
    task = Task.new( task_name:"", description: "miss_test" )
    expect(task).not_to be_valid
  end
  it ""

end