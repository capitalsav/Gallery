require 'rails_helper'

describe 'ImagesPage', type: :feature do
  before(:each) do
    @user = create(:user)
    visit '/users/sign_in'
    fill_in 'sing-in-email-input', with: @user.email
    fill_in 'sign-in-password-input', with: @user.password
    click_button 'btn-sign-in'
  end

  it 'should registered user be able to visit images page', js: true do
    visit '/images'
    expect(page).to have_current_path(images_path)
  end
end
