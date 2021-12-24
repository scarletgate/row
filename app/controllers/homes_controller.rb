class HomesController < ApplicationController
  def top
    @posts = Post.limit(10).where(is_shered: 'true').reverse_order
    @tag_lists = Tag.all
  end

  def about
  end
end
