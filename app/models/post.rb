class Post < ApplicationRecord
  belongs_to :user
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :notifications, dependent: :destroy
  has_many :tag_maps, dependent: :destroy
  has_many :tags, through: :tag_maps
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

  #タグの作成
  def create_tag(sent_tags)
    current_tags = self.tags.pluck(:tag_name) unless self.tags.nil?
    #unless self.tags.blank?
      #current_tags = self.tags.pluck(:tag_name)
      old_tags = current_tags - sent_tags #登録タグから送信されてきたタグを除き、すでに登録されていたタグを抽出
      new_tags = sent_tags - current_tags #送信されてきたタグから現在存在するタグを除き、新たに登録するタグを抽出
      old_tags.each do |old|
        self.post_tag.delete Tag.find_by(tag_name: old)
      end
      new_tags.each do |new|
        new_post_tag = Tag.find_or_create_by(tag_name: new)
        self.tags << new_post_tag
      end
    #end
  end

end
