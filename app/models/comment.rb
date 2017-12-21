class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :image
  validates :user_id, presence: true
  validates :image_id, presence: true
  has_many :comments_categories, :through => :images, :source => :categories
end
