class TasksController < ApplicationController
  before_action :set_task, only: [:show,:edit,:update,:destroy]

  def index
    if params[:sort_expired] == "true"
      @tasks = Task.order(deadline: :desc)
    elsif params[:sort_rank] == "true"
      @tasks = Task.order(rank: :desc)
    elsif params[:search].present?
      if params[:search][:task_name].present? && params[:search][:status].present?
        @tasks = Task.search_task_name(params[:search][:task_name]).search_status(params[:search][:status])
      elsif params[:search][:task_name].present?
        @tasks = Task.search_task_name(params[:search][:task_name])
      else
        @tasks = Task.search_status(params[:search][:status])
      end
    else
      @tasks = Task.order(created_at: :desc)
    end
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to @task,notice: "タスクが登録されました"
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
      redirect_to task_path, notice: "タスクは更新されました"
    else
      render "edit"
    end
  end

  def destroy
    @task.destroy
    redirect_to root_path,notice: "タスクは削除されました"
  end

  private

  def task_params
    params.require(:task).permit(:task_name, :description, :deadline, :status, :rank )
  end

  def set_task
    @task = Task.find(params[:id])
  end
end
