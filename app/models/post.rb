class Post < ApplicationRecord
  belongs_to :user
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :notifications, dependent: :destroy
  attachment :post_image

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  #いいねの通知
  def create_notification_favorite(current_user)
    notification = current_user.active_notifications.new(post_id: id, visited_id: user_id, action: "favorite")
    #自分の投稿に対する自分のいいねはcheckedをtrueに（通知済み）する
    if notification.visiter_id == notification.visited_id
      notification.checked = true
    end
    notification.save if notification.valid?
  end

  #コメントの通知
  def create_notification_comment(current_user)
    notification = current_user.active_notifications.new(post_id: id, post_comment_id: post_comments, visited_id: user_id, action: "comment")
    #自分の投稿に対する自分のコメントはcheckedをtrueに（通知済み）する
    if notification.visiter_id == notification.visited_id
      notification.checked = true
    end
    notification.save if notification.valid?
  end

end
