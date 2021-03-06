class SearchsController < ApplicationController
  def search
    @model = params["model"]      # 選択した検索対象を@modelへ渡す
    @method = params["method"]    # 選択した検索方法を@methodへ渡す
    @content = params["content"]  # 検索内容を@contentへ渡す
    @records = search_for(@model, @method, @content).page(params[:page]).reverse_order
  end

  private

  def search_for(model, method, content)
    if model == 'user' # 選択した検索対象がユーザーだったら
      if method == 'perfect'
        User.where(name: content)
      else
        User.where('name LIKE ?', '%' + content + '%')
      end
    elsif model == 'post' # 選択した検索対象が投稿だったら
      if method == 'perfect'
        Post.where(title: content).where(is_shered: 'true')
      else
        Post.where('title LIKE ?', '%' + content + '%').where(is_shered: 'true')
      end
    end
  end
end
