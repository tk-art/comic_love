class Post < ApplicationRecord
  belongs_to :user
  has_many :post_categories, dependent: :destroy
  has_many :categories, through: :post_categories
  accepts_nested_attributes_for :post_categories
  has_many :comments, dependent: :destroy
  has_many :notifications, dependent: :destroy

  validates :user_id, presence: true
  validates :title, presence: true
  validates :isbn, presence: true
  validates :image_url, presence: true
  validates :url, presence: true
  validates :content, presence: true, length: { maximum: 150 }

  def self.search(search, user_or_post)
    if user_or_post == '2'
      where(['title LIKE ?', "%#{search}%"])
    else
      all
    end
  end

  def create_notification_comment!(current_user, comment_id)
    temp_ids = Comment.select(:user_id).where(post_id: id).where.not(user_id: current_user.id).distinct
    temp_ids.each do |temp_id|
      save_notification_comment!(current_user, comment_id, temp_id['user_id'])
    end
  end

  def save_notification_comment!(current_user, comment_id, visited_id)
    notification = current_user.myself_notifications.build(
      post_id: id,
      comment_id: comment_id,
      visited_id: visited_id,
      action: 'comment'
    )
    notification.checked = true if notification.visitor_id == notification.visited_id
    notification.save if notification.valid?
  end
end
