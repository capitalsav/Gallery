# Controller for authentication via social networks
class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def google_oauth2
    user = ::User.from_omniauth(request.env['omniauth.auth'])
    user.save! unless User.exists?(email: user.email)
    set_flash_message(:success, :success)
    sign_in(User.find_by(email: user.email), scope: :user)
    redirect_to root_path
  end
end
