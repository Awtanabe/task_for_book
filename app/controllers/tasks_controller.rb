class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit]
  def index
    @q = current_user.tasks.ransack(params[:q])
    @tasks = @q.result(distinct: true)
  end

  def show
  end

  def new
    @task = Task.new
  end

  def confirm_new
    @task = current_user.tasks.new(task_params)
    render :new unless @task.valid?
  end

  def create
    @task = Task.new(task_params.merge(user_id: current_user.id))
    
    if params[:back].present?
      render :new
      return
    end
    if @task.save
      TaskMailer.creation_email(@task).deliver_now
      flash[:notice] = "タスク#{@task.name}を登録しました"
      redirect_to tasks_url
    else
      render :new
    end
    
  end

  def edit
  end

  def update
    task = current_user.tasks.find(params[:id])
    task.update!(task_params)
    flash[:notice] = "タスクを更新しました"
    redirect_to tasks_url
  end

  def destroy
    task = current_user.tasks.find(params[:id])
    task.destroy
    flash[:notice] = "削除完了しました"
    redirect_to tasks_url
  end

  private
  def task_params
    params.require(:task).permit(:name,:description, :image)
  end

  def set_task
    @task = current_user.tasks.find(params[:id])
  end
end
