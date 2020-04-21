class TasksController < ApplicationController
  before_action :set_task, only: [:show,:edit,:update,:destroy]

  def index
    if params[:sort_expired] == "true"
      @tasks = Task.order(deadline: :desc)
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
    params.require(:task).permit(:task_name, :description, :deadline)
  end

  def set_task
    @task = Task.find(params[:id])
  end
end
