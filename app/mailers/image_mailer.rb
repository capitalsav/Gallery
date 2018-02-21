# frozen_string_literal: true

# Mailer for notifications about new uploaded images
class ImageMailer < ApplicationMailer
  default from: 'notifications@capitalsav.com'

  def new_image_email(category, image, user)
    @category = category
    @image = image
    @user = user
    mail(to: @user['email'],
         subject:
          <<~HEREDOC
            New image was successfully
            uploaded to your subscribed category
          HEREDOC
        )
  end
end
