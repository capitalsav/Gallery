class UserAction < ApplicationRecord
  ACTION_SIGN_IN = 'SIGN_IN'
  ACTION_SIGN_OUT = 'SIGN_OUT'
  ACTION_NAVIGATION = 'NAVIGATION'
  ACTION_LIKES = 'LIKES'
  ACTION_COMMENT = 'COMMENT'
  PATH_SIGN_OUT = '/sign_out'
  belongs_to :user

  def self.save_user_action(user_id, action_type, url)
    action_params = {"user_id" => user_id, "action_type" => action_type, "url" => url}
    user_action = UserAction.new(action_params)
    user_action.save
  end
end
