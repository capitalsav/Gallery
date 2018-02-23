# frozen_string_literal: true

# Admin user actions page
ActiveAdmin.register UserAction do
  filter :user, as: :select, collection: proc { User.all.map { |user| [user.email, user.id] } }

  scope :all, default: true
  scope UserAction::ACTION_NAVIGATION do |actions|
    actions.where(action_type: UserAction::ACTION_NAVIGATION)
  end
  scope UserAction::ACTION_SIGN_IN do |actions|
    actions.where(action_type: UserAction::ACTION_SIGN_IN)
  end
  scope UserAction::ACTION_SIGN_OUT do |actions|
    actions.where(action_type: UserAction::ACTION_SIGN_OUT)
  end
  scope UserAction::ACTION_LIKES do |actions|
    actions.where(action_type: UserAction::ACTION_LIKES)
  end
  scope UserAction::ACTION_COMMENTS do |actions|
    actions.where(action_type: UserAction::ACTION_COMMENTS)
  end

  index do
    column { |action| action.user.email }
    column do |action|
      link_to action.action_type,
      admin_user_actions_path('q[user_id_eq]': action.user.id,
                              'scope': action.action_type)
    end
    column :url
    column { |action| action.created_at.strftime('%Y-%m-%d %H:%M:%S') }
  end
end
