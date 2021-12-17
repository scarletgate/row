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
    temp = Notification.where(["visiter_id = ? and visited_id = ? and post_id = ? and action = ?",current_user.id,user_id, id, 'favorite'])
    if temp.blank?#いいねがされていない場合に通知を作成
      notification = current_user.active_notifications.new(post_id: id, visited_id: user_id, action: "favorite")
      #自分の投稿に対する自分のいいねはcheckedをtrueに（通知済み）する
      if notification.visiter_id == notification.visited_id
        notification.checked = true
      end
      notification.save if notification.valid?
    end
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
