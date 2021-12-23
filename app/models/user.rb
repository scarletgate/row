class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  # いいね一覧画面表示用
  has_many :favorite_posts, through: :favorites, source: :post
  # Relationshipモデルのfollower_idとfollowed_idカラムを参照
  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  # フォロー・フォロワーの一覧画面表示用
  has_many :followings, through: :relationships, source: :followed
  has_many :followers, through: :reverse_of_relationships, source: :follower
  # Notificationモデルのvisiter_idとvisited_idカラムを参照　active:自分が送った通知　passive:自分宛の通知
  has_many :active_notifications, class_name: "Notification", foreign_key: "visiter_id", dependent: :destroy
  has_many :passive_notifications, class_name: "Notification", foreign_key: "visited_id", dependent: :destroy
  attachment :profile_image

  validates :name,
    presence: true,
    uniqueness: true,
    length: { maximum: 20 }

  # フォローする
  def follow(user_id)
    relationships.create(followed_id: user_id)
  end

  # フォローを外す
  def unfollow(user_id)
    relationships.find_by(followed_id: user_id).destroy
  end

  # フォローしているか判定
  def following?(user)
    followings.include?(user)
  end

  def create_notification_follow(current_user)
    temp = Notification.where(["visiter_id = ? and visited_id = ? and action = ?", current_user.id, id, 'follow'])
    if temp.blank?
      notification = current_user.active_notifications.new(visited_id: id, action: 'follow')
      notification.save if notification.valid?
    end
  end
end
