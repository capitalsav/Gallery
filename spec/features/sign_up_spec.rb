# frozen_string_literal: true

require 'rails_helper'

describe 'UserSignup', type: :feature do
  before(:each) do
    @user = create(:user)
    visit '/users/sign_up'
  end

  it 'should allow user to sign up' do
    fill_in 'sign-up-name-input', with: @user.name
    fill_in 'sign-up-email-input', with: @user.email
    fill_in 'sign-up-password-input', with: @user.password
    fill_in 'sign-up-password-confirm-input', with: @user.password
    click_button 'btn-sign-up'
    expect(page).to have_current_path('/en/users')
  end

  it 'should click on Login route to new_registration_path', js: true do
    click_on 'shared-login-link'
    expect(page).to have_current_path("/en#{new_user_session_path}")
  end

  it 'click on don\'t receive conf route to new_confirmation_path', js: true do
    click_on 'shared-confirmation-link'
    expect(page).to have_current_path("/en#{new_user_confirmation_path}")
  end
end
