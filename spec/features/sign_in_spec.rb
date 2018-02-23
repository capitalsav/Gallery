# frozen_string_literal: true

require 'rails_helper'

describe 'UserSignin', type: :feature do
  before(:each) do
    @user = create(:user)
    visit '/users/sign_in'
  end

  it 'should allow a registered user to sign in', js: true do
    fill_in 'sing-in-email-input', with: @user.email
    fill_in 'sign-in-password-input', with: @user.password
    click_button 'btn-sign-in'
    expect(page).to have_current_path('/en')
  end

  it 'should click on sign-up route to new_registration_path', js: true do
    click_on 'shared-sing-up-link'
    expect(page).to have_current_path("/en#{new_user_registration_path}")
  end

  it 'should click on forgot password route to new_password_path', js: true do
    click_on 'shared-forgot-pwd-link'
    expect(page).to have_current_path("/en#{new_user_password_path}")
  end

  it 'click on don\'t receive conf route to new_confirmation_path', js: true do
    click_on 'shared-confirmation-link'
    expect(page).to have_current_path("/en#{new_user_confirmation_path}")
  end
end
