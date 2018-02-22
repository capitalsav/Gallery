# frozen_string_literal: true

# Mailer for notifications about category subscription
class CategoryMailer < ApplicationMailer
  default from: 'notifications@capitalsav.com'

  def subscribe_email(user, category)
    @user = user
    @category = category
    mail(to: @user['email'],
         subject:
          <<~HEREDOC
            You have successfully
            subscribe on new category
          HEREDOC
        )
  end
end
