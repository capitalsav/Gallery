class CategoryMailer < ApplicationMailer
  default from: 'notifications@capitalsav.com'

  def subscribe_email(user, category)
    @user = user
    @category = category
    mail(to: @user.email, subject: 'You have successfully subscribe on new category')
  end
end
