class User < ApplicationRecord
  mount_uploader :image, AvatarUploader
  validates_processing_of :image
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  mount_uploader :avatar, AvatarUploader
  validates_processing_of :avatar
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :categories, foreign_key: 'user_id', dependent: :destroy
  has_many :likes, foreign_key: "user_id", dependent: :destroy
  has_many :liked_images, :through => :likes, :source => :images
  has_many :comments, foreign_key: "user_id", dependent: :destroy
  has_many :commented_images, :through => :comments, :source => :images
  

  def likes?(image_id)
    likes.find_by(image_id: image_id)
  end

  def like_image!(image_id)
    likes.create!(image_id: image_id)
  end

  def unlike_image(image_id)
    likes.find_by(image_id: image_id).destroy!
  end
end
