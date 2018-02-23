# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ImageMailer, type: :mailer do
  before(:each) do
    @user = create(:user)
    @category = create(:category, user_id: @user.id)
    @image = create(:image, user_id: @user.id, category_id: @category.id)
  end
  include ActiveJob::TestHelper
  it 'new_image_mail is sent' do
    expect do
      perform_enqueued_jobs do
        ImageMailer.new_image_email(@category, @image, @user).deliver
      end
    end.to change { ActionMailer::Base.deliveries.size }.by(1)
  end

  it 'renders the headers' do
    perform_enqueued_jobs do
      ImageMailer.new_image_email(@category, @image, @user).deliver
    end
    mail = ActionMailer::Base.deliveries.last
    expect(mail.subject).to eq('New image was successfully uploaded to your subscribed category')
    expect(mail.to).to eq([@user.email])
    expect(mail.from).to eq(['notifications@capitalsav.com'])
  end

  it 'renders the body' do
    perform_enqueued_jobs do
      ImageMailer.new_image_email(@category, @image, @user).deliver
    end
    mail = ActionMailer::Base.deliveries.last
    expect(mail.body.encoded).to match('Hello,')
    expect(mail.body.encoded).to match(@user.name.to_s)
    expect(mail.body.encoded).to match(@category.name.to_s)
  end
end
