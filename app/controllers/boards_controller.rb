class BoardsController < ApplicationController
  before_action :authenticate_user!

  def index
    # 記事を全て取得
    @boards = Board.all
  end

  def new
    @board = current_user.boards.build
  end

  def create
    @board = current_user.boards.build(board_params)
    if @board.save
      redirect_to boards_path, notice: '登録に成功しました'
    else
      flash.now[:notice] = '登録に失敗しました'
      render :new
    end
  end

  private

  def board_params
    params.require(:board).permit(:title, :description)
  end
end
