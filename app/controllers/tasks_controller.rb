class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit]
  def index
    @tasks = Task.all
  end

  def show
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params.merge(user_id: current_user.id))
    
    if @task.save
      flash[:notice] = "タスク#{@task.name}を登録しました"
      redirect_to tasks_url
    else
      render :new
    end
    
  end

  def edit
  end

  def update
    task = Task.find(params[:id])
    task.update!(task_params)
    flash[:notice] = "タスクを更新しました"
    redirect_to tasks_url
  end

  def destroy
    task = Task.find(params[:id])
    task.destroy
    flash[:notice] = "削除完了しました"
    redirect_to tasks_url
  end

  private
  def task_params
    params.require(:task).permit(:name,:description)
  end

  def set_task
    @task = Task.find(params[:id])
  end
end
