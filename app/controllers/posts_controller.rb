class PostsController < ApplicationController
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]
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
      redirect_to post_path(@post.id), notice: "投稿が作成されました。"
    else
      @tag_lists = Tag.all
      render :new
    end
  end

  def index
    @posts = Post.page(params[:page]).where(is_shered: 'true').reverse_order
    @tag_list = Tag.all
  end

  def show
    @post = Post.find(params[:id])
    @user = @post.user
    @post_comment = PostComment.new
    @post_tag = @post.tags.pluck(:tag_name).join(' ')
  end

  def edit
    @tag_list = @post.tags.pluck(:tag_name).join(' ')
    @tag_lists = Tag.all
  end

  def update
    tag_list = params[:post][:tag_name].split(' ')
    if @post.update(post_params)
      @post.create_tag(tag_list)
      redirect_to post_path(@post.id), notice: "正常に更新されました。"
    else
      @tag_lists = Tag.all
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to user_path(@post.user_id)
  end

  private

  def post_params
    params.require(:post).permit(:title, :content, :post_image, :is_shered)
  end

  def ensure_correct_user
    @post = Post.find(params[:id])
    unless @post.user == current_user
      redirect_to post_path(@post.id)
    end
  end
end
