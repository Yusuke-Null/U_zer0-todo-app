class TasksController < ApplicationController
  before_action :authenticate_user!

  def index
    @tasks = Task.where(board_id: params[:board_id])
    @task_title = Board.find(params[:board_id]).title
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


  private
  def task_params
    params.require(:task).permit(
      :user_id,
      :board_id,
      :title,
      :content,
      :deadline)
  end
end
