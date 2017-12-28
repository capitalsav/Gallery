class Category < ApplicationRecord
  belongs_to :user
  has_many :images, foreign_key: 'category_id', dependent: :destroy
  has_many :subscriptions, foreign_key: "category_id", dependent: :destroy
  has_many :subscribed_users, :through => :subscriptions, :source => :user
  has_many :commented_categories, :through => :images, :source => :comments
  has_many :liked_categoties, :through => :images, :source => :likes
end
