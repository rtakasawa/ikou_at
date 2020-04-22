require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do

  describe 'タスク一覧画面' do
    before do
      FactoryBot.create(:task)
      FactoryBot.create(:second_task)
      FactoryBot.create(:third_task)
    end
    context '複数のタスクを作成した場合' do
      it '作成済みのタスクが表示される' do
        visit tasks_path
        expect(page).to have_content "test_name1"
        expect(page).to have_content "test_name2"
        expect(page).to have_content "test_name3"
      end
    end
    context '複数のタスクを作成した場合' do
      it 'タスクが作成日時の降順に並んでいる' do
        visit tasks_path
        task_list = all('tbody tr' )
        expect(task_list[0]).to have_content "test_name3"
        expect(task_list[1]).to have_content "test_name2"
        expect(task_list[2]).to have_content "test_name1"
      end
    end

    context "検索した場合" do
      it "タスク名検索ができる" do
        visit tasks_path
        fill_in "search[task_name]", with: 'test_name1'
        click_on "検索する"
        expect(page).to have_content 'test_name1'
      end
      it "ステータス検索ができる" do
        visit tasks_path
        select "未着手", from: "search[status]"
        click_on "検索する"
        expect(page).to have_content '未着手'
      end
      it "タスク名とステータスの両方で検索ができる" do
        visit tasks_path
        fill_in "search[task_name]", with: 'test_name1'
        select "未着手", from: "search[status]"
        click_on "検索する"
        expect(page).to have_content 'test_name1'
        expect(page).to have_content '未着手'
      end
    end

    context "複数のタスクを作成した場合" do
      it "ソートボタンをクリックすると終了期限の降順に並び替えることができる" do
        visit tasks_path
        click_on "終了期限でソートする"
        task_list = all('tbody tr' )
        expect(task_list[0]).to have_content "test_name3"
        expect(task_list[1]).to have_content "test_name2"
        expect(task_list[2]).to have_content "test_name1"
      end
    end
  end

  describe 'タスク登録画面' do
    context '必要項目を入力して、createボタンを押した場合' do
      it 'データが保存される' do
        visit new_task_path
        fill_in 'task[task_name]', with: "test_task_name"
        fill_in 'task[description]', with: "test_description"
        fill_in 'task[deadline]', with: Date.today
        click_button "登録する"
        expect(page).to have_content "test_task_name"
        expect(page).to have_content "test_description"
        expect(page).to have_content Date.today
      end
    end
  end
  describe 'タスク詳細画面' do
    context '任意のタスク詳細画面に遷移した場合' do
      it '該当タスクの内容が表示されたページに遷移する' do
        FactoryBot.create(:task)
        visit tasks_path
        click_on "test_name1"
        expect(page).to have_content "test_name1"
        expect(page).to have_content "test_description1"
        expect(page).to have_content '1900-01-01'
      end
    end
  end
end