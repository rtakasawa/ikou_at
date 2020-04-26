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
      Task.create(task_name: "name_test1",
                  description: "test_description1",
                  deadline: Date.today,
                  status: "未着手",
                  rank: 0, user_id: 1)
      Task.create(task_name: "name_test2",
                  description: "test_description2",
                  deadline: Date.today,
                  status: "着手中",
                  rank: 1, user_id: 2)
    end
    it "scopeメソッドでタスク名検索ができる" do
      expect(Task.search_task_name("name").count).to eq 2
    end
    it "scopeメソッドでステータス検索ができる" do
      expect(Task.search_status("着手中").count).to eq 1
    end
    it "scopeメソッドでタスク名とステータスでの両方で検索ができる" do
      expect(Task.search_task_name("name").search_status("未着手").count).to eq 1
    end
  end
end