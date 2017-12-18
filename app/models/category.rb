class Category < ApplicationRecord
  has_many :images, foreign_key: 'category_id', dependent: :destroy
  has_many :subscriptions, foreign_key: "category_id", dependent: :destroy
  has_many :subscribed_users, :through => :subscriptions, :source => :user
end
