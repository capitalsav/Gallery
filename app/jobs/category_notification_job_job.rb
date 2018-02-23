# frozen_string_literal: true

# Job for mailers category subscription notifications
class CategoryNotificationJobJob
  @queue = :category_notification

  def self.perform(user, category)
    CategoryMailer.subscribe_email(user, category).deliver
  end
end
