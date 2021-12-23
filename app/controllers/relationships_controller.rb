class RelationshipsController < ApplicationController
  def create
    user = User.find(params[:user_id])
    current_user.follow(user.id)
    user.create_notification_follow(current_user)
    redirect_to request.referer
  end

  def destroy
    current_user.unfollow(params[:user_id])
    redirect_to request.referer
  end

  # フォロー一覧
  def followings
    @user = User.find(params[:user_id])
    @users = @user.followings
  end

  # フォロワー一覧
  def followers
    @user = User.find(params[:user_id])
    @users = @user.followers
  end
end
