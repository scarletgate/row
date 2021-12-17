class FavoritesController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    favorite = Favorite.new(post_id: @post.id) #post_idカラムに@post.idを入れた空のモデルをfavoriteに渡す。
    favorite.user_id = current_user.id #favoriteのuser_idカラムにログインユーザーのuser.idを渡す。
    favorite.save
    @post.create_notification_favorite(current_user)
  end

  def destroy
    @post = Post.find(params[:post_id])
    favorite = Favorite.find_by(post_id: @post.id)
    favorite.user_id = current_user.id
    favorite.destroy
  end

  #いいね一覧
  def index
    @user = User.find(params[:user_id])
    @favorites = @user.favorites
  end

end
