class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :lockable, :validatable

  has_many :posts
  validates :name, presence: true, length: { maximum: 30 }
  validates :email, presence: true, length: { maximum: 255 }, uniqueness: true, allow_blank: true
  validates :profile, length: { maximum: 140 }
  mount_uploader :image, ImageUploader
end
