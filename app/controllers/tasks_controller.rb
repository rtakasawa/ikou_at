class TasksController < ApplicationController
  before_action :set_task, only: [:show,:edit,:update,:destroy]
  before_action :login_check

  def index
    if params[:sort_expired] == "true"
      @tasks = current_user.tasks.order(deadline: :desc).page(params[:page])
    elsif params[:sort_rank] == "true"
      @tasks = current_user.tasks.order(rank: :desc).page(params[:page])
    elsif params[:search].present?
      if params[:search][:task_name].present? && params[:search][:status].present?
        @tasks = current_user.tasks.search_task_name(params[:search][:task_name])
                   .search_status(params[:search][:status])
                   .page(params[:page])
      elsif params[:search][:task_name].present?
        @tasks = current_user.tasks.search_task_name(params[:search][:task_name]).page(params[:page])
      else
        @tasks = current_user.tasks.search_status(params[:search][:status]).page(params[:page])
      end
    else
      @tasks = current_user.tasks.order(created_at: :desc).page(params[:page]).per(10)
    end
  end

  def new
    @task = current_user.tasks.build
  end

  def create
    @task = @task = current_user.tasks.build(task_params)
    if @task.save
      redirect_to @task, success: "タスクが登録されました"
    else
      render "new"
    end
  end

  def show
  end

  def edit
  end

  def update
    if @task.update(task_params)
      redirect_to task_path, info: "タスクは更新されました"
    else
      render "edit"
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_path, info: "タスクは削除されました"
  end

  private

  def task_params
    params.require(:task).permit(:task_name, :description, :deadline, :status, :rank )
  end

  def set_task
    @task = Task.find(params[:id])
  end

  def login_check
    unless logged_in?
      redirect_to root_path
    end
  end
end