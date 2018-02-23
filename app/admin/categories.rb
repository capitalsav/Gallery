# frozen_string_literal: true

# Admin categories page
ActiveAdmin.register Category do
  permit_params :name, :user_id, :slug

  index do
    column :id
    column :name
    column ('User') { |category| category.user }
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
