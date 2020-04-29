require 'rails_helper'
RSpec.describe  "ユーザー登録・ログイン・ログアウト機能", type: :system do

  describe "ユーザー登録のテスト" do
    context "ユーザーのデータがなくログインしていない場合" do
      it "ユーザー新規登録テスト" do
        visit new_user_path
        fill_in "user[name]", with: "sample"
        fill_in "user[email]", with: "sample@example.com"
        fill_in "user[password]", with: '0000000'
        fill_in "user[password_confirmation]", with: '0000000'
        click_on "登録する"
        expect(current_path).to eq tasks_path
      end
      it "ログインしていないときは、ログイン画面に飛ぶテスト" do
        visit tasks_path
        expect(current_path).to eq new_session_path
      end
    end
  end

  describe "セッション機能のテスト" do
    context "ユーザーを登録している場合" do
      before do
        create(:user)
        create(:admin_user)
        visit new_session_path
        fill_in "session[email]", with: "sample@example.com"
        fill_in "session[password]", with: "0000000"
        click_on "ログインする"
      end
      it "ログインできること" do
        expect(current_path).to eq tasks_path
      end
      it "自分の詳細画面(マイページ)に飛べること" do
        click_on "マイページ"
        expect(current_path).to eq user_path(id: 1)
      end
      it "一般ユーザが他人の詳細画面に飛ぶとタスク一覧ページに遷移すること" do
        visit user_path(id: 2)
        expect(current_path).to eq tasks_path
      end
      it "ログアウトができること" do
        click_on "ログアウト"
        expect(current_path).to eq new_session_path
      end
    end
  end

  describe "管理画面のテスト" do
    context "管理者登録をしている場合" do
      before do
        create(:user)
        create(:admin_user)
        create(:second_admin_user)
        visit new_session_path
      end
      it "管理者は管理画面にアクセスできること" do
        fill_in "session[email]", with: "admine@example.com"
        fill_in "session[password]", with: "0000000"
        click_on "ログインする"
        click_on "管理者ページ"
        expect(current_path).to eq admin_users_path
      end
      it "一般ユーザは管理画面にアクセスできないこと" do
        fill_in "session[email]", with: "sample@example.com"
        fill_in "session[password]", with: "0000000"
        click_on "ログインする"
        visit admin_users_path
        expect(current_path).to eq tasks_path
      end
      it "管理者はユーザを新規登録できること" do
        fill_in "session[email]", with: "admine@example.com"
        fill_in "session[password]", with: "0000000"
        click_on "ログインする"
        click_on "管理者ページ"
        click_on "ユーザー登録"
        fill_in "user[name]", with: "admin2"
        fill_in "user[email]", with: "admin2@example.com"
        check "user[admin]"
        fill_in "user[password]", with: '0000000'
        fill_in "user[password_confirmation]", with: '0000000'
        click_on "登録する"
        expect(page).to have_content "admin2"
      end
      it "管理者はユーザの詳細画面にアクセスできること" do
        fill_in "session[email]", with: "admine@example.com"
        fill_in "session[password]", with: "0000000"
        click_on "ログインする"
        click_on "管理者ページ"
        click_on "sample"
        expect(current_path).to eq admin_user_path(id: 1)
      end
      it "管理者はユーザの編集画面からユーザを編集できること" do
        fill_in "session[email]", with: "admine@example.com"
        fill_in "session[password]", with: "0000000"
        click_on "ログインする"
        click_on "管理者ページ"
        click_link href: "/admin/users/1/edit"
        fill_in "user[name]", with: "admin2"
        fill_in "user[email]", with: "admin2@example.com"
        check "user[admin]"
        fill_in "user[password]", with: '0000000'
        fill_in "user[password_confirmation]", with: '0000000'
        click_on "登録する"
        expect(page).to have_content "admin2"
      end
      it "管理者はユーザの削除をできること" do
        fill_in "session[email]", with: "admine@example.com"
        fill_in "session[password]", with: "0000000"
        click_on "ログインする"
        click_on "管理者ページ"
        click_link "ユーザー削除", href: "/admin/users/1"
        page.accept_confirm
        expect(page).to have_no_content "sample"
      end
    end
  end
end