class PostCommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    comment = PostComment.new(post_comment_params) #commentカラム空のモデルをcommentに渡す。
    comment.user_id = current_user.id #commentのuser_idカラムにログインユーザーのuser.idを渡す。
    comment.post_id = @post.id #commentのpost_idカラムにコメントをしたpost.idを渡す。
    comment.save
  end

  def destroy
    @post = Post.find(params[:post_id])
    PostComment.find_by(id: params[:id]).destroy #PostCommentからidが一致するコメントを探して削除
  end

  private
  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end
end
