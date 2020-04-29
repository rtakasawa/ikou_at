require 'rails_helper'
RSpec.describe  "ユーザー登録機能" do
  it "nameが空ならバリデーションが通らない" do
    user = User.new(name: "", email: "sample@example.com", password: "0000000")
    expect(user).not_to be_valid
  end
  it "nameが30文字以上ならバリデーションが通らない" do
    user = User.new(name: "a"*31, email: "sample@example.com", password: "0000000")
    expect(user).not_to be_valid
  end
  it "emailが空ならバリデーションが通らない" do
    user = User.new(name: "sample", email: "", password: "0000000")
    expect(user).not_to be_valid
  end
  it "emailが既に登録済みの場合、バリデーションが通らない" do
    create(:user)
    user = User.new(name: "sample_2", email: "sample@example.com", password: "0000000")
    expect(user).not_to be_valid
  end
  it "emailの入力形式が適切でない場合、バリデーションが通らない" do
    user = User.new(name: "sample", email: "aaaaaaaa", password: "0000000")
    expect(user).not_to be_valid
  end
  it "emailの255文字以上ならバリデーションが通らない" do
    user = User.new(name: "sample", email: "a"*248+"@example.com", password: "0000000")
    expect(user).not_to be_valid
  end
  it "passwordが空ならバリデーションが通らない" do
    user = User.new(name: "sample", email: "sample@example.com", password: "")
    expect(user).not_to be_valid
  end
  it "passwordが6文字未満ならバリデーションが通らない" do
    user = User.new(name: "sample", email: "sample@example.com", password: "aaaaa")
    expect(user).not_to be_valid
  end

  context "管理者が一人の場合" do
    it "管理者のユーザー登録は削除できない（メソッドが呼び出されているか）" do
      user = create(:admin_user)
      allow(user).to receive(:must_not_destroy_last_admin_user)
      user.destroy
      expect(user).to have_received(:must_not_destroy_last_admin_user)
    end
    it "管理者のユーザー権限は削除できない（メソッドが呼び出されているか）" do
      user = create(:admin_user ,admin: true)
      allow(user).to receive(:must_not_destroy_last_admin_user)
      user.update(id: 1, name: "sample", email: "sample@example.com", password: "0000000",admin: false)
      expect(user).to have_received(:must_not_destroy_last_admin_user)
    end
  end
end