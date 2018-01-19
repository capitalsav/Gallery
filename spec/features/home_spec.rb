require 'rails_helper'

describe 'HomePage', type: :feature do
  before(:each) do
    visit root_path
  end

  it 'should company name route to root_path', js: true do
    visit categories_path
    click_on 'company-name'
    expect(current_path) == root_path
  end

  it 'should header images route to images#index', js: true do
    click_on 'header-images'
    expect(current_path) == images_path
  end

  it 'should header comments route to comments#index', js: true do
    click_on 'header-comments'
    expect(current_path) == comments_path
  end

  it 'should header comments route to comments#index', js: true do
    click_on 'header-dropdown-categories'
    click_on 'header-all-categories'
    expect(current_path) == categories_path
  end

  it 'should header sign-up route to users/registrations#new', js: true do
    click_on 'header-sign-up'
    expect(current_path) == new_user_registration_path
  end

  it 'should header login route to users/registrations#new', js: true do
    click_on 'header-login'
    expect(current_path) == new_user_session_path
  end

  it 'should user be able to change language', js: true do
    click_on 'header-dropdown-lang'
    click_on 'header-ru'
    expect(page).to have_content('Категории')
    expect(page).to have_no_content('Categories')
    click_on 'header-dropdown-lang'
    click_on 'header-en'
    expect(page).to have_content('Categories')
    expect(page).to have_no_content('Категории')
  end
end
