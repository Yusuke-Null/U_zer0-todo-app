class CommentsController < ApplicationController
  before_action :authenticate_user!

  def new
    @comment = current_user.comments.build
  end

  def create
    @comment = current_user.comments.build(comment_params)
    @comment.task_id = params[:task_id]

    if @comment.save
      redirect_to board_task_path(id: params[:task_id]), notice: 'コメントを登録しました'
    else
      flash.now[:error] = 'コメントの登録に失敗しました'
      render :new
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:user_id, :task_id, :comment)
  end
end
