class FavoritesController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    #favorite = current_user.favorites.new(post_image_id: post_image.id)
    favorite = Favorite.new(post_id: @post.id)#post_idカラムに@post.idを入れた空のモデルをfavoriteに渡す。
    favorite.user_id = current_user.id
    favorite.save
  end

  def destroy
    @post = Post.find(params[:post_id])
    #favorite = current_user.favorites.find_by(post_image_id: post_image.id)
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
