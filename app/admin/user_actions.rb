ActiveAdmin.register UserAction do
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
  filter :user, :as => :select, :collection => proc {User.all.map {|user| [user.email, user.id]}}

  scope :all, :default => true
  scope UserAction::ACTION_NAVIGATION do |actions|
    actions.where("action_type" => UserAction::ACTION_NAVIGATION)
  end
  scope UserAction::ACTION_SIGN_IN do |actions|
    actions.where("action_type" => UserAction::ACTION_SIGN_IN)
  end
  scope UserAction::ACTION_SIGN_OUT do |actions|
    actions.where("action_type" => UserAction::ACTION_SIGN_OUT)
  end
  scope UserAction::ACTION_LIKES do |actions|
    actions.where("action_type" => UserAction::ACTION_LIKES)
  end
  scope UserAction::ACTION_COMMENTS do |actions|
    actions.where("action_type" => UserAction::ACTION_COMMENTS)
  end

  index do
    column {|action| action.user.email}
    # column :action_type
    column {|action| link_to "#{action.action_type}", admin_user_actions_path('q[user_id_eq]' => action.user.id, 'scope' => action.action_type)}
    column :url
    column {|action| action.created_at.strftime("%Y-%m-%d %H:%M:%S")}
  end
end