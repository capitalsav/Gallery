# frozen_string_literal: true

# Model of subscription user on category
class Subscription < ApplicationRecord
  belongs_to :user
  belongs_to :category
  validates :user_id, :category_id, presence: true
end
