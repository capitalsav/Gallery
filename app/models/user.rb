# Model of User for current web app
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  mount_uploader :avatar, AvatarUploader
  validates_processing_of :avatar
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable
  has_many :images, foreign_key: 'user_id', dependent: :destroy
  has_many :categories, foreign_key: 'user_id', dependent: :destroy
  has_many :likes, foreign_key: 'user_id', dependent: :destroy
  has_many :liked_images, class_name: 'Image', through: :likes, source: :images
  has_many :comments, foreign_key: 'user_id', dependent: :destroy
  has_many :commented_images, class_name: 'Image', through: :comments, source: :images
  has_many :subscriptions, foreign_key: 'user_id', dependent: :destroy
  has_many :subscribed_categories, class_name: 'Category', through: :subscriptions, source: :categories
  has_many :user_actions, foreign_key: 'user_id', dependent: :destroy
  validates :email, presence: true
  validates :encrypted_password, presence: true, length: { minimum: 6 }

  def likes?(image_id)
    likes.find_by(image_id: image_id)
  end

  def subscribed?(category_id)
    subscriptions.find_by(category_id: category_id)
  end

  def self.from_omniauth(auth)
    user = User.new
    user.email = auth.info.email
    user.password = Devise.friendly_token[0,20]
    user.name = auth.info.name   # assuming the user model has a name
    user.avatar = auth.info.image # assuming the user model has an image
    # If you are using confirmable and the provider(s) you use validate emails,
    # uncomment the line below to skip the confirmation emails.
    user.skip_confirmation!
    user
  end
end
