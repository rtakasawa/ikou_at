class TasksController < ApplicationController
  before_action :set_task, only: [:show,:edit,:update,:destroy]
  before_action :login_check_task

  def index
    # 終了期限でソート
    if params[:sort_expired] == "true"
      @tasks = current_user.tasks.order(deadline: :desc).page(params[:page])
      # 優先順位でソート
    elsif params[:sort_rank] == "true"
      @tasks = current_user.tasks.order(rank: :desc).page(params[:page])
      # 検索機能
    elsif params[:search].present?
      @search_params = task_search_params
      @tasks = current_user.tasks.search(@search_params).includes(:labels).page(params[:page])
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
    params.require(:task).permit(:task_name, :description, :deadline, :status, :rank, { label_ids: [] })
  end

  def set_task
    @task = Task.find(params[:id])
    # @task = current_user.tasks.find(params[:id])
  end

  def login_check_task
    unless logged_in?
      redirect_to new_session_path
    end
  end

  def task_search_params
    params.fetch(:search, {}).permit(:task_name, :status, :label_id)
  end
end