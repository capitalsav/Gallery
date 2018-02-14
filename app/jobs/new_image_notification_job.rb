# frozen_string_literal: true

# Job for notification about new images
class NewImageNotificationJob
  @queue = :new_image_notification

  def self.perform(category, image, users)
    users.each do |user|
      ImageMailer.new_image_email(category, image, user).deliver
    end
  end
end
