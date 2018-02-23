# frozen_string_literal: true

# Mailer for notifications about category subscription
class CategoryMailer < ApplicationMailer
  default from: 'notifications@capitalsav.com'

  def subscribe_email(user, category)
    @user = user
    @category = category
    subject = 'You have successfully subscribe on new category'
    mail(to: @user['email'], subject: subject)
  end
end
