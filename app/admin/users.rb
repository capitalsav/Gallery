ActiveAdmin.register User do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
permit_params :email, :name, :password
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end
  form do |f|
    f.semantic_errors # shows errors on :base
    f.input :email
    f.input :name
    f.input :password
    f.actions         # adds the 'Submit' and 'Cancel' buttons
  end
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
    actions
  end

  controller do
    def update
      if params[:user][:password].blank?
        params[:user].delete("password")
        params[:user].delete("password_confirmation")
      end
      if params[:user][:email].blank?
        params[:user].delete("email")
        params[:user].delete("email_confirmation")
      end
      super
    end
  end
  before_save do |user|
    user.skip_confirmation!
    user.skip_reconfirmation!
  end
end