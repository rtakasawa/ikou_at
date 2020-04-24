class UsersController < ApplicationController
  before_action :login_check_user, only: [:new]

  def new
    @user = User.new
  end

  def create
    @user = User.new(params_user)
    if @user.save
      session[:user_id] = @user.id
      redirect_to tasks_path, info: "ユーザー登録しました"
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to tasks_path
    end
  end

  private
  def params_user
    params.require(:user).permit(:name, :email, :password, :password_confirmation )
  end

  def login_check_user
    if logged_in?
      redirect_to tasks_path
    end
  end
end