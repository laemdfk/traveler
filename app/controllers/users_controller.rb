class UsersController < ApplicationController

# ActionController::InvalidAuthenticityTokenの予防用コード
# protect_from_forgery


  def show
  # @book = Book.find(params[:id])
    @books = Book.all
     @book = Book.new
     @user = current_user
    @users = User.where(user_id: current_user.id).includes(:user).order("created_at DESC")
     #↑自分が投稿したものだけを表示させるための制御文。
     #includes(:user)=プログラムの無駄な処理を軽減 / order("created_at DESC")=新規投稿順に並べさせる
  end

  def index
    @users = User.all
    @user = current_user
    @books = Book.all
    @book = Book.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice]="You have updated user successfully."
      redirect_to user_path(current_user)
    else
      render :edit
    end
  end


  private
# 以下、ストロングパラメータ/必ずラストのエンド前に。

  def user_params
    params.require(:user).permit(:name, :introduction, :user_id, :profile_image)
  end
end