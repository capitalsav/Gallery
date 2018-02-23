# frozen_string_literal: true

# Mailer for notifications about new uploaded images
class ImageMailer < ApplicationMailer
  default from: 'notifications@capitalsav.com'

  def new_image_email(category, image, user)
    @category = category
    @image = image
    @user = user
    subject = 'New image was successfully uploaded to your subscribed category'
    mail(to: @user['email'], subject: subject)
  end
end
