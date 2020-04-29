require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do

  wait = Selenium::WebDriver::Wait.new(:timeout => 1000)

  describe 'タスク一覧画面' do
    before do
      User.create(id: 1, name: "sample", email: "sample@example.com",
                  password: "0000000",admin: false)
      Label.create(id: 1, title:"work")
      task_first = create(:task, user_id: 1)
      task_second = create(:second_task, user_id: 1)
      task_third = create(:third_task, user_id: 1)
      task_first.task_to_labels.create(id:1, label_id: 1)
      task_second.task_to_labels.create(id:2, label_id: 1)
      task_third.task_to_labels.create(id:3, label_id: 1)
      visit new_session_path
      fill_in "session[email]", with: "sample@example.com"
      fill_in "session[password]", with: "0000000"
      click_on "ログインする"
    end

    context '複数のタスクを作成した場合' do
      it '作成済みのタスクが表示される' do
        wait.until{ expect(page).to have_content "test_name1" }
        wait.until{ expect(page).to have_content "test_name2" }
        wait.until{ expect(page).to have_content "test_name3" }
      end
      it 'タスクが作成日時の降順に並んでいる' do
        task_list = all('tbody tr' )
        wait.until{ expect(task_list[0]).to have_content "test_name3" }
        wait.until{ expect(task_list[1]).to have_content "test_name2" }
        wait.until{ expect(task_list[2]).to have_content "test_name1" }
      end
    end

    context '任意のタスクを削除した場合' do
      it '削除したタスクが表示されない' do
        click_link "削除", href: "/tasks/1"
        page.accept_confirm
        wait.until{ expect(page).to have_no_content 'test_name1' }
      end
    end

    context "検索した場合" do
      it "タスク名検索ができる" do
        fill_in "search[task_name]", with: 'test_name1'
        click_on "検索する"
        wait.until{ expect(page).to have_content 'test_name1' }
      end
      it "ステータス検索ができる" do
        select "未着手", from: "search[status]"
        click_on "検索する"
        wait.until{ expect(page).to have_content '未着手' }
      end
      it "ラベル検索ができる" do
        select "work", from: "search[label_id]"
        click_on "検索する"
        wait.until{ expect(page).to have_content 'work' }
      end
      it "タスク名とステータスとラベルを指定して、検索ができる" do
        fill_in "search[task_name]", with: 'test_name1'
        select "未着手", from: "search[status]"
        select "work", from: "search[label_id]"
        click_on "検索する"
        wait.until{ expect(page).to have_content 'test_name1' }
        wait.until{ expect(page).to have_content '未着手' }
        wait.until{ expect(page).to have_content 'work' }
      end
    end

    context "複数のタスクを作成した場合" do
      it "終了期限のソートボタンをクリックすると終了期限を昇順に並び替えることができる", :retry => 3 do
        click_on "終了期限でソートする"
        task_list = all('tbody tr' )
        wait.until{ expect(task_list[0]).to have_content '1900-01-01' }
        wait.until{ expect(task_list[1]).to have_content '2000-01-01' }
        wait.until{ expect(task_list[2]).to have_content '2100-01-01' }
      end
      it "優先順位のソートボタンをクリックすると優先順位を降順に並び替えることができる", :retry => 3 do
        click_on "優先順位でソートする"
        task_list = all('tbody tr' )
        wait.until{ expect(task_list[0]).to have_content '高' }
        wait.until{ expect(task_list[1]).to have_content '中' }
        wait.until{ expect(task_list[2]).to have_content '低' }
      end
    end
  end

  describe 'タスク登録画面' do
    context '必要項目を入力して、createボタンを押した場合' do
      it 'データが保存される' do
        User.create(id: 1, name: "sample", email: "sample@example.com",
                    password: "0000000",admin: false)
        Label.create(id: 1, title:"work")
        Label.create(id: 2, title:"private")
        Label.create(id: 3, title:"other")
        create(:task, user_id: 1)
        visit new_session_path
        fill_in "session[email]", with: "sample@example.com"
        fill_in "session[password]", with: "0000000"
        click_on "ログインする"
        click_on "タスク登録"
        fill_in 'task[task_name]', with: "task_name"
        fill_in 'task[description]', with: "description"
        fill_in 'task[deadline]', with: Date.today
        check 'task_label_ids_1'
        check 'task_label_ids_2'
        check 'task_label_ids_3'
        click_button "登録する"
        wait.until{ expect(page).to have_content "task_name" }
        wait.until{ expect(page).to have_content "description" }
        wait.until{ expect(page).to have_content Date.today }
        wait.until{ expect(page).to have_content "work" }
        wait.until{ expect(page).to have_content "private" }
        wait.until{ expect(page).to have_content "other" }
      end
    end
  end

  describe 'タスク詳細画面' do
    before do
      User.create(id: 1, name: "sample", email: "sample@example.com",
                  password: "0000000",admin: false)
      create(:task, user_id: 1)
      visit new_session_path
      fill_in "session[email]", with: "sample@example.com"
      fill_in "session[password]", with: "0000000"
      click_on "ログインする"
    end
    context '任意のタスク詳細画面に遷移した場合' do
      it '該当タスクの内容が表示されたページに遷移する' do
        click_on 'test_name1'
        wait.until{ expect(page).to have_content "test_name1" }
        wait.until{ expect(page).to have_content "test_description1" }
        wait.until{ expect(page).to have_content '1900-01-01' }
      end
    end
    context '任意のタスクを削除した場合' do
      it '削除したタスクが表示されない' do
        click_link "削除", href: "/tasks/1"
        page.accept_confirm
        wait.until{ expect(page).to have_no_content 'test_name1' }
      end
    end
  end

  describe 'タスク編集画面' do
    context '必要項目を入力して、createボタンを押した場合' do
      it 'データが保存される' do
        User.create(id: 1, name: "sample", email: "sample@example.com",
                    password: "0000000",admin: false)
        Label.create(id: 1, title:"work")
        Label.create(id: 2, title:"private")
        Label.create(id: 3, title:"other")
        create(:task, user_id: 1)
        visit new_session_path
        fill_in "session[email]", with: "sample@example.com"
        fill_in "session[password]", with: "0000000"
        click_on "ログインする"
        click_link href: "/tasks/1/edit"
        fill_in 'task[task_name]', with: "task_name"
        fill_in 'task[description]', with: "description"
        fill_in 'task[deadline]', with: Date.today
        check 'task_label_ids_1'
        check 'task_label_ids_2'
        check 'task_label_ids_3'
        click_button "登録する"
        wait.until{ expect(page).to have_content "task_name" }
        wait.until{ expect(page).to have_content "description" }
        wait.until{ expect(page).to have_content Date.today }
        wait.until{ expect(page).to have_content "work" }
        wait.until{ expect(page).to have_content "private" }
        wait.until{ expect(page).to have_content "other" }
      end
    end
  end
end