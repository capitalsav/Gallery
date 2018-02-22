# frozen_string_literal: true

ActiveAdmin.register Category do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
permit_params :name, :user_id, :slug
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
    column :name
    column ('User'){|category| category.user}
    column :created_at
    column :updated_at
    actions
  end

  controller do
    def find_resource
      scoped_collection.friendly.find(params[:id])
    end
  end
end
