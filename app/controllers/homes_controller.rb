class HomesController < ApplicationController
  def top
    @posts = Post.limit(10).order("created_at DESC").where(is_shered: 'true')
  end

  def about
  end
end
