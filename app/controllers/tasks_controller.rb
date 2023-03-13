class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index

    if params[:sort_expired]
      @tasks = Task.all.order(deadline: :desc)
    else
      @tasks = Task.all.order(created_at: :desc)
    end

    if params[:sort_priority]
      # @tasks = Task.all
      @tasks = @tasks.order(priority: :asc)
    end

    if params[:task].present?
      # if params[:task][:name].present? && params[:task][:status].present?
      #   #name and statusが成り立つ検索結果を返す
      #   @tasks = Task.name_search(params)
      #   @tasks = Task.status_search(params)
        
        #パラメータがtask nameのみだったとき
        
      if params[:task][:name].present?
        @tasks = @tasks.name_search(params[:task][:name])
      end
      
        #パラメータがステータスのみだったとき
      if params[:task][:status].present?
        @tasks = @tasks.status_search(params[:task][:status])
      end
    end

    @tasks = @tasks.page(params[:page])
  end

  

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if params[:back]
      render :new
    else
      if @task.save
        redirect_to tasks_path, notice:"タスク「#{@task.name}」を作成しました！"
      else
        render :new
      end
    end
  end

  def confirm
    @task = Task.new(task_params)
    render :new if @task.invalid?
  end

  def show
  end

  def edit
  end

  def update
    if @task.update(task_params)
      redirect_to tasks_path, notice:"タスク「#{@task.name}」を編集しました！"
    else
      render edit
    end
  end
  def destroy
    @task.destroy
    redirect_to tasks_path, notice:"タスク「#{@task.name}」を削除しました！"
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end
  def task_params
    params.require(:task).permit(:name, :content, :deadline, :status, :priority)
  end
end
