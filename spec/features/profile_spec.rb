require 'rails_helper'

describe 'ProfilePage', type: :feature do
  before(:each) do
    @user = create(:user)
    visit '/users/sign_in'
    fill_in 'sing-in-email-input', with: @user.email
    fill_in 'sign-in-password-input', with: @user.password
    click_button 'btn-sign-in'
  end

  it 'should registered user be able to visit his profile page' do
    visit '/profile'
    expect(page).to have_current_path(profile_path)
  end

  it 'should registered user be able to change his username', js: true do
    visit '/profile'
    fill_in 'profile-name-input', with: Faker::Name.first_name
    fill_in 'profile-cur-pwd-input', with: @user.password
    click_button 'btn-update-account'
    expect(page).to have_current_path('/en')
    expect(page).to have_content('Your account has been updated successfully.')
  end

  it 'should registered user be able to change his password', js: true do
    visit '/profile'
    fill_in 'profile-pwd-input', with: '123456'
    fill_in 'profile-pwd-confirm-input', with: '123456'
    fill_in 'profile-cur-pwd-input', with: @user.password
    click_button 'btn-update-account'
    expect(page).to have_current_path('/en')
    expect(page).to have_content('Your account has been updated successfully.')
  end

  it 'should registered user be able to change his email', js: true do
    visit '/profile'
    fill_in 'profile-email-input', with: Faker::Internet.email
    fill_in 'profile-cur-pwd-input', with: @user.password
    click_button 'btn-update-account'
    expect(page).to have_current_path('/en')
    expect(page).to have_content('Your account has been updated successfully.')
  end

  it 'should registered user be able to change his avatar', js: true do
    visit '/profile'
    attach_file('user[avatar]',
                File.join(Rails.root,
                          '/spec/fixtures/solnce-kosmos-merkuriy.jpg'),
                visible: false)
    fill_in 'profile-cur-pwd-input', with: @user.password
    click_button 'btn-update-account'
    expect(page).to have_current_path('/en')
    expect(page).to have_content('Your account has been updated successfully.')
  end
end
