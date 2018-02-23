# frozen_string_literal: true

require 'rails_helper'

describe 'CommentsPage', type: :feature do
  before(:each) do
    @user = create(:user)
    visit '/users/sign_in'
    fill_in 'sing-in-email-input', with: @user.email
    fill_in 'sign-in-password-input', with: @user.password
    click_button 'btn-sign-in'
    visit '/categories'
    click_on 'btn-new-category'
    expect(page).to have_current_path("/en#{new_category_path}")
    fill_in 'category_name', with: 'Test'
    click_button 'btn-create category'
    visit '/categories'

    first('.fa', visible: false).click

    expect(page).to have_current_path("/en#{category_path(
      id: Category.last.slug.to_s
    )}")
    click_on 'btn-upload-images'

    expect(page).to have_current_path("/en#{new_image_path(
      id: Category.last.slug.to_s
    )}")

    attach_file('image[image]',
                File.join(Rails.root,
                          '/spec/fixtures/solnce-kosmos-merkuriy.jpg'),
                visible: false)
    click_on('btn-upload-img')

    expect(page).to have_current_path("/en#{single_category_image_path(
      id: Category.last.slug.to_s, image_id: Image.last.id.to_s
    )}")

    visit category_path(id: Category.last.slug.to_s)
    first('.fa', visible: false).click

    expect(page).to have_current_path("/en#{single_category_image_path(
      id: Category.last.slug.to_s, image_id: Image.last.id.to_s
    )}")
  end

  it 'should allow a registered user to leave a comment on image', js: true do
    fill_in 'input-comment', with: 'Comment'
    click_on 'btn-comment'
    expect(page).to have_content('Comment')
  end

  it 'should allow user to see all comments on comments page', js: true do
    fill_in 'input-comment', with: 'Comment'
    click_on 'btn-comment'
    expect(page).to have_content('Comment')
    visit comments_path
    expect(page).to have_content('Comment')
  end
end
