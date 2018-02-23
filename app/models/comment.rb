# frozen_string_literal: true

# Model of comment to image
class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :image
  validates :user_id, :image_id, :text, presence: true
end
