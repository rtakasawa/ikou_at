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
      #検索機能
    elsif params[:search].present?
      @search_params = task_search_params
      @tasks = current_user.tasks.search(@search_params).includes(:labels).page(params[:page])
    else
      @tasks = current_user.tasks.order(created_at: :desc).page(params[:page]).per(10)
    end

    # # 終了期限でソート
    # if params[:sort_expired] == "true"
    #   @tasks = current_user.tasks.order(deadline: :desc).page(params[:page])
    #   # 優先順位でソート
    # elsif params[:sort_rank] == "true"
    #   @tasks = current_user.tasks.order(rank: :desc).page(params[:page])
    #   #検索機能
    # elsif params[:search].present?
    #   binding.irb
    #   if params[:search][:task_name].present? && params[:search][:status].present?
    #     @tasks = current_user.tasks.search_task_name(params[:search][:task_name])
    #                .search_status(params[:search][:status])
    #                .page(params[:page])
    #     # タスク名の検索機能
    #   elsif params[:search][:task_name].present?
    #     @tasks = current_user.tasks.search_task_name(params[:search][:task_name]).page(params[:page])
    #     # 優先順位の検索機能
    #   elsif params[:search][:status].present?
    #     @tasks = current_user.tasks.search_status(params[:search][:status]).page(params[:page])
    #     # ラベルの検索機能
    #   else
    #     @task_id = TaskToLabel.search_label_id(params[:search][:label_id]).pluck(:task_id)
    #     @tasks = current_user.tasks.search_task_to_label(@task_id).page(params[:page])
    #   end
    #   # 検索条件がない場合
    # else
    #   @tasks = current_user.tasks.order(created_at: :desc).page(params[:page]).per(10)
    # end
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