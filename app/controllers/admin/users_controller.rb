class Admin::UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :destroy]
  before_action :check_admin

  def index
    @users = User.includes(:tasks).order(created_at: :desc).page(params[:page]).per(10)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params_user)
    if @user.save
      redirect_to admin_users_path, info: "ユーザー登録しました"
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
    @user_tasks = @user.tasks
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    if @user.update(params_user)
      redirect_to admin_users_path, info: "ユーザー情報を更新しました"
    else
      render :edit
    end
  end

  def destroy
    if @user.destroy
      redirect_to admin_users_path, info: "ユーザー情報を削除しました"
    else
      redirect_to admin_users_path, danger: '削除できません。少なくとも1人の管理者は必要です。'
    end
  end

  private
  def params_user
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :admin )
  end

  def set_user
    @user = User.find(params[:id])
  end

  def check_admin
    redirect_to tasks_path, danger: "あなたは管理者ではありません" unless current_user.admin?
  end
end