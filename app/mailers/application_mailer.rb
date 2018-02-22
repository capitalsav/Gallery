# frozen_string_literal: true

# Basic Apllication mailer class
class ApplicationMailer < ActionMailer::Base
  default from: 'from@example.com'
  layout 'mailer'
end
