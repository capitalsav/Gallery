ActiveAdmin.register User do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end

  filter :created_at

  index  do
    column :email
    column :name
    column :current_sign_in_at
    column :last_sign_in_at
    column :current_sign_in_ip
    column :last_sign_in_ip
    column :confirmed_at
    column :confirmation_sent_at
    column :unconfirmed_email
    column :created_at
    column :updated_at
    column ('Avatar') do |user|
      if user.avatar.present?
        image_tag user.avatar.small_thumb.url
    end
  end
  end
end