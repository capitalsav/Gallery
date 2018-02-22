# frozen_string_literal: true

ActiveAdmin.register Image do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
  permit_params :image, :user, :category, :category_id, :user_id
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end

  index do
    column :id
    column ('Image') {|image| image_tag image.image.small_thumb.url}
    column("Image Path"){|image| link_to "#{image.image}", single_category_image_path(image.category.name, image.id) }
    column :category
    column :user
    column :created_at
    column :updated_at
    actions
  end
end
