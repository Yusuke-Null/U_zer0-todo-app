class TasksController < ApplicationController
  before_action :authenticate_user!

  def index
    @tasks = Task.where(board_id: params[:board_id])
    @board = Board.find(params[:board_id])
    @user = User.new
  end

  def new
    @task = current_user.tasks.build
  end

  def create
    @task = current_user.tasks.build(task_params)
    @task.board_id = params[:board_id]
    if @task.save
      redirect_to board_tasks_path, notice: '登録しました'
    else
      flash.now[:error] = '登録に失敗しました'
      render :new
    end
  end

  def show
    @task = Task.find(params[:id])
    @user = User.new
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
    if @task.update(task_params)
      redirect_to board_task_path(@task), notice: 'タスクの更新に成功しました'
    else
      flash.now[:error] = 'タスクの更新に失敗しました'
      render :edit
    end
  end

  def destroy
    task = Task.find(params[:id])
    task.destroy!
    redirect_to board_tasks_path, notice: 'タスクを削除しました'
  end

  private
  def task_params
    params.require(:task).permit(
      :user_id,
      :board_id,
      :title,
      :content,
      :deadline,
      :eyecatch)
  end
end
