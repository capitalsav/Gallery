class UserAction < ApplicationRecord
  ACTION_SIGN_IN = 'SIGN_IN'
  ACTION_SIGN_OUT = 'SIGN_OUT'
  PATH_SIGN_OUT = '/sign_out'
  belongs_to :user
end
