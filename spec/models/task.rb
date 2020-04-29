require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :model do
  before do
    User.create(id: 1, name: "sample", email: "sample@aaa.com", password: "0000000",admin: false)
    User.create(id: 2, name: "sample2", email: "sample2@aaa.com", password: "0000000",admin: false)
  end

  it "task_nameが空ならバリデーションが通らない" do
    task = Task.new( task_name:"", description: "miss_test", deadline: Date.today, user_id: 1 )
    expect(task).not_to be_valid
  end
  it "descriptionが空ならバリデーションは通らない" do
    task = Task.new( task_name:"miss_test", description: "", deadline: Date.today, user_id: 1 )
    expect(task).not_to be_valid
  end
  it "deadlineが空ならバリデーションは通らない" do
    task = Task.new( task_name:"miss_test", description: "miss_test", deadline: "", user_id: 1 )
    expect(task).not_to be_valid
  end
  it "task_nameとdescriptionとstatusが記載されていればバリデーションが通る" do
    task = Task.new( task_name:"ok_test_name",
                     description: "ok_test_description",
                     deadline: Date.today, user_id: 1 )
    expect(task).to be_valid
  end

  context "scopeメソッドで検索をした場合" do
    before do
      Label.create(id: 1, title:"work")
      Label.create(id: 2, title:"private")
      task_first = create(:task, user_id: 1)
      task_second = create(:second_task, user_id: 2)
      task_first.task_to_labels.create(id:1, label_id: 1)
      task_first.task_to_labels.create(id:2, label_id: 2)
      task_second.task_to_labels.create(id:3, label_id: 1)
    end
    it "scopeメソッドでタスク名検索ができる" do
      expect(Task.search_task_name("name").count).to eq 2
    end
    it "scopeメソッドでステータス検索ができる" do
      expect(Task.search_status("着手中").count).to eq 1
    end
    it "scopeメソッドでラベル検索ができる" do
      expect(Task.search_label(2).count).to eq 1
    end
    it "scopeメソッドでタスク名とステータスとラベルでの検索ができる" do
      expect(Task.search(task_name: "name", status: "未着手", label_id: 1).count).to eq 1
    end
  end
end