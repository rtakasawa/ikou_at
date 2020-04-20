require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :model do
  it "task_nameが空ならバリデーションが通らない" do
    task = Task.new( task_name:"", description: "miss_test" )
    expect(task).not_to be_valid
  end
  it "descriptionが空ならバリデーションは通らない" do
    task = Task.new( task_name:"miss_test", description: "" )
    expect(task).not_to be_valid
  end
  it "task_nameとdescriptionが記載されていればバリデーションが通る" do
    task = Task.new( task_name:"ok_test_name", description: "ok_test_description" )
    expect(task).to be_valid
  end

end