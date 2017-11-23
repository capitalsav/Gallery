class Image < ApplicationRecord
  belongs_to :category
  mount_uploader :image, ImageUploader
  validates_processing_of :image
  validate :image_size_validation

  private
  def image_size_validation
    errors[:image] << "should be less than 10500KB" if image.size > 10.5.megabytes
  end
end
