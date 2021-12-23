class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @posts = @user.posts.page(params[:page])
    @favorite_posts = @user.favorite_posts
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user.id)
    else
      render :edit
    end
  end

  def check
    @user = User.find(params[:id])
  end

  # 退会機能を論理削除で実装予定
  # def withdrawal
  #   @user = User.find(params[:id])
  #   @user.update(is_deleted: true)
  #   reset_session
  #   flash[:notice] = "退会処理を実行しました。"
  #   redirect_to root_path
  # end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end
end
