class TasksController < ApplicationController
  before_action :set_message, only: [:show, :edit, :update, :destroy]
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy,:show,:edit,:update]
  
  def index
    #@tasks = Task.all.page(params[:page])
    if logged_in?
      # form_for 用
      @task = current_user.tasks.build
      @tasks = current_user.tasks.order('created_at DESC').page(params[:page])
    end
  end

  def show
  end

  def new
    @task = Task.new
  end

  def create
    #@task = Task.new(task_params)
    @task = current_user.tasks.build(task_params)
    if @task.save
      flash[:success] = 'タスクが投稿されました'
      redirect_to @task
    else
      @tasks = current_user.tasks.order('created_at DESC').page(params[:page])
      flash[:danger] = 'タスクが投稿されません'
      render :new
    end
  end

  def edit
  end


  def update
    @task = Task.find(params[:id])
  
    if @task.update(task_params)
      flash[:success] = 'タスクが編集されました'
      redirect_to @task
    else
      flash.now[:danger] = 'タスクが編集されませんでした'
      render :edit
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
  
    flash[:success] = 'タスクが削除されました'
    redirect_to tasks_path
  end

  private
  
  def set_message
    @task = Task.find(params[:id])
  end
  
  def task_params
    params.require(:task).permit(:content, :status)
  end
  
  def correct_user
    @task = current_user.tasks.find_by(id: params[:id])
    unless @task
      redirect_to tasks_path
      flash[:danger] = '  あなた以外のタスクは閲覧及び編集はできません。'
    end
  end
  
  
  
end