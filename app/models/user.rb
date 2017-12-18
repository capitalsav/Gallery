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
  has_many :subscriptions, foreign_key: 'user_id', dependent: :destroy
  has_many :subscribed_categories, :through => :subscriptions, :source => :categories
  

  def likes?(image_id)
    likes.find_by(image_id: image_id)
  end

  def like_image!(image_id)
    likes.create!(image_id: image_id)
  end

  def unlike_image(image_id)
    likes.find_by(image_id: image_id).destroy!
  end

  def subscribed?(category_id)
    subscriptions.find_by(category_id: category_id)
  end

  def subscribe!(category_id)
    subscriptions.create!(category_id: category_id)
  end

  def unsubscribe(category_id)
    subscriptions.find_by(category_id: category_id).destroy!
  end
end
