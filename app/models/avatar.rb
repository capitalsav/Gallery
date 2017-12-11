class Avatar < ApplicationRecord
  belongs_to :user
  validates :image, presence: true
  validates :user_id, presence: true
  mount_uploader :image, AvatarUploader
  validates_processing_of :image
end
