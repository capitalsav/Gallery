# frozen_string_literal: true

require 'rails_helper'

describe 'Sign out', type: :feature do
  before(:each) do
    @user = create(:user)
    visit '/users/sign_in'
    fill_in 'sing-in-email-input', with: @user.email
    fill_in 'sign-in-password-input', with: @user.password
    click_button 'btn-sign-in'
  end

  it 'should registered user be able to sign out', js: true do
    click_on 'header-logout'
    expect(page).to have_current_path('/en')
    expect(page).to have_content('Signed out successfully')
  end
end
