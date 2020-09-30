class Post < ApplicationRecord
  belongs_to :user
  validates :user_id, presence: true
  validates :title, presence: true
  validates :isbn, presence: true
  validates :image_url, presence: true
  validates :url, presence: true
  validates :content, presence: true, length: { maximum: 150 }
end
