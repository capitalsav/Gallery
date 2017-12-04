class Category < ApplicationRecord
  has_many :images, foreign_key: 'category_id', dependent: :destroy
end
