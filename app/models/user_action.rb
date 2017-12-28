class UserAction < ApplicationRecord
  ACTION_SIGN_IN = 'sign_in'
  ACTION_SIGN_OUT = 'sign_out'
  ACTION_NAVIGATION = 'navigation'
  ACTION_LIKES = 'likes'
  ACTION_COMMENTS = 'comments'
  PATH_SIGN_OUT = '/users/sign_out'
  belongs_to :user

  def self.save_user_action(user_id, action_type, url)
    action_params = {"user_id" => user_id, "action_type" => action_type, "url" => url}
    user_action = UserAction.new(action_params)
    user_action.save
  end
end