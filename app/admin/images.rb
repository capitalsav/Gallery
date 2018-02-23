# frozen_string_literal: true

# Admin image page
ActiveAdmin.register Image do
  permit_params :image, :user, :category, :category_id, :user_id

  index do
    column :id
    column ('Image') { |image| image_tag image.image.small_thumb.url }
    column ('Image Path') do |image|
      link_to image.image, single_category_image_path(image.category.name,
                                                      image.id)
    end
    column :category
    column :user
    column :created_at
    column :updated_at
    actions
  end
end
