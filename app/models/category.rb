# frozen_string_literal: true

# Model category of image which was uploaded by user
class Category < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  belongs_to :user
  has_many :images, foreign_key: 'category_id', dependent: :destroy
  has_many :subscriptions, foreign_key: 'category_id', dependent: :destroy
  has_many :subscribed_users, through: :subscriptions, source: :user
  has_many :commented_categories, through: :images, source: :comments
  has_many :liked_categoties, through: :images, source: :likes
  validates :name, :user_id, presence: true
end
