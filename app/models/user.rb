class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  before_create :default_image
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :lockable, :validatable

  has_many :posts, dependent: :destroy
  has_many :active_relationships, class_name: 'Relationship',
                                  foreign_key: 'follower_id',
                                  dependent: :destroy
  has_many :passive_relationships, class_name: 'Relationship',
                                   foreign_key: 'followed_id',
                                   dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships
  has_many :comments
  has_many :myself_notifications, class_name: 'Notification',
                                  foreign_key: 'visitor_id',
                                  dependent: :destroy
  has_many :opponent_notifications, class_name: 'Notification',
                                    foreign_key: 'visited_id',
                                    dependent: :destroy

  validates :name, presence: true, length: { maximum: 30 }
  validates :email, presence: true, length: { maximum: 255 }, uniqueness: true, allow_blank: true
  validates :profile, length: { maximum: 140 }
  has_one_attached :image

  def self.guest
    find_or_create_by!(email: 'guest@g.com') do |user|
      user.password = SecureRandom.urlsafe_base64
    end
  end

  def follow(other_user)
    active_relationships.create(followed_id: other_user.id)
  end

  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  def following?(other_user)
    following.include?(other_user)
  end

  def self.search(search, user_or_post)
    if user_or_post == '1'
      where(['name LIKE ?', "%#{search}%"])
    else
      all
    end
  end

  def create_notification_follow!(current_user)
    temp = Notification.where(['visitor_id = ? and visited_id = ? and action = ? ', current_user.id, id, 'follow'])
    if temp.blank?
      notification = current_user.myself_notifications.build(
        visited_id: id,
        action: 'follow'
      )
      notification.save if notification.valid?
    end
  end

  def feed
    following_ids = "SELECT followed_id FROM relationships
                     WHERE follower_id = :user_id"
    Post.where("user_id IN (#{following_ids})
                     OR user_id = :user_id", user_id: id)
  end

  private

  def default_image
    # image.attach(File.open(Rails.root.join('app', 'assets', 'images', 'default.jpg'))) unless image.attached?
    unless image.attached?
      image.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'default.jpg')),
                   filename: 'display-image.jpg', content_type: 'image/jpg')
    end
  end
end
