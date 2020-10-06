class Post < ApplicationRecord
  belongs_to :user
  has_many :post_categories, dependent: :destroy
  has_many :categories, through: :post_categories
  accepts_nested_attributes_for :post_categories

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
end
