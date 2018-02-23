# frozen_string_literal: true

describe 'UserSignin', type: :feature do
  before(:each) do
    @user = create(:user)
    visit '/users/sign_in'
    fill_in 'sing-in-email-input', with: @user.email
    fill_in 'sign-in-password-input', with: @user.password
    click_button 'btn-sign-in'
    visit '/categories'
  end

  it 'should allow a registered user to create category and go to it page',
     js: true do
    click_on 'btn-new-category'
    expect(page).to have_current_path("/en#{new_category_path}")
    fill_in 'category_name', with: 'Test'
    click_button 'btn-create category'
    visit '/categories'
    first('.fa', visible: false).click
    expect(page).to have_current_path("/en#{category_path(
      id: Category.last.slug.to_s
    )}")
  end
end
