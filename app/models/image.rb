# frozen_string_literal: true

class Image < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_many :likes, foreign_key: "image_id", dependent: :destroy
  has_many :liking_users, :through => :likes, :source => :user
  has_many :comments, foreign_key: "image_id", dependent: :destroy
  has_many :commenting_users, :through => :comments, :source => :user
  mount_uploader :image, ImageUploader
  validates_presence_of :image
  validate :image_size_validation

  private
  def image_size_validation
    errors[:image] << "should be less than 50MB" if image.size > 50.megabytes
  end
end
