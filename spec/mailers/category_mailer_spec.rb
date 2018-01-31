require 'rails_helper'
RSpec.describe CategoryMailer, type: :mailer do
  before(:each) do
    @user = create(:user)
    @category = create(:category, user_id: @user.id)
  end
  include ActiveJob::TestHelper
  it 'subscription_mail is sent' do
    expect do
      perform_enqueued_jobs do
        CategoryMailer.subscribe_email(@user, @category).deliver
      end
    end.to change { ActionMailer::Base.deliveries.size }.by(1)
  end

  it 'renders the headers' do
    perform_enqueued_jobs do
      CategoryMailer.subscribe_email(@user, @category).deliver
    end
    mail = ActionMailer::Base.deliveries.last
    expect(mail.subject).to eq(
      'You have successfully subscribe on new category'
    )
    expect(mail.to).to eq([@user.email])
    expect(mail.from).to eq(['notifications@capitalsav.com'])
  end

  it 'renders the body' do
    perform_enqueued_jobs do
      CategoryMailer.subscribe_email(@user, @category).deliver
    end
    mail = ActionMailer::Base.deliveries.last
    expect(mail.body.encoded).to match('Hello,')
    expect(mail.body.encoded).to match(@user.name.to_s)
    expect(mail.body.encoded).to match(@category.name.to_s)
  end
end
