require 'rails_helper'

describe 'UserSignin', type: :feature do
  before(:each) do
    @user = create(:user)
    visit '/users/sign_up'
  end

  it 'should allow user to sign up', js: true do
    fill_in 'sign-up-name-input', with: @user.name
    fill_in 'sign-up-email-input', with: @user.email
    fill_in 'sign-up-password-input', with: @user.password
    fill_in 'sign-up-password-confirm-input', with: @user.password
    click_button 'btn-sign-up'
    expect(current_path) == root_path
  end

  it 'should click on Login route to new_registration_path', js: true do
    click_on 'shared-login-link'
    expect(current_path) == new_user_session_path
  end

  it 'click on don\'t receive conf route to new_confirmation_path', js: true do
    click_on 'shared-confirmation-link'
    expect(current_path) == new_user_confirmation_path
  end
end
