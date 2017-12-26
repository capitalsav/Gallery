class UserAction < ApplicationRecord
  ACTION_SIGN_IN = 'SIGN_IN'
  ACTION_SIGN_OUT = 'SIGN_OUT'
  ACTION_NAVIGATION = 'NAVIGATION'
  ACTION_LIKES = 'LIKES'
  ACTION_COMMENT = 'COMMENT'
  PATH_SIGN_OUT = '/sign_out'
  belongs_to :user
end
