class UsersController < ApplicationController
  before_action :ensure_user, only: [:edit, :update]
  def show
    @user = User.find(params[:id])
    @posts = @user.posts.page(params[:page]).reverse_order
    @favorite_posts = @user.favorite_posts
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user.id), notice: "正常に更新されました。"
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

  def ensure_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(@user.id)
    end
  end
end
