class Notification < ApplicationRecord

  #デフォルトの並び順を作成日時の降順に
  default_scope->{order(created_at: :desc)}
  belongs_to :post, optional: true
  belongs_to :post_comment, optional: true
  belongs_to :visiter, class_name: 'User', foreign_key: 'visiter_id', optional: true
  belongs_to :visited, class_name: 'User', foreign_key: 'visited_id', optional: true

end