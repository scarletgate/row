class PostsController < ApplicationController
  def new
    @post = Post.new
    @tag_lists = Tag.all
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    tag_list = params[:post][:tag_name].split(' ')
    if @post.save
      @post.create_tag(tag_list)
      redirect_to post_path(@post.id)
    else
      redirect_to post_path(@post.id)
    end
  end

  def index
    @posts = Post.page(params[:page]).reverse_order
    @tag_list = Tag.all
  end

  def show
    @post = Post.find(params[:id])
    @user = @post.user
    @post_comment = PostComment.new
    @post_tags = @post.tags
  end

  def edit
    @post = Post.find(params[:id])
    @tag_list = @post.tags.pluck(:tag_name).join(' ')
    @tag_lists = Tag.all
  end

  def update
    @post = Post.find(params[:id])
    tag_list = params[:post][:tag_name].split(' ')
    if @post.update(post_params)
      @post.create_tag(tag_list)
      redirect_to post_path(@post.id)
    end
  end

  def destroy
    @post =Post.find(params[:id])
    @post.destroy
    redirect_to user_path(@post.user_id)
  end

  private
  def post_params
    params.require(:post).permit(:title, :content, :post_image, :is_shered )
  end

end