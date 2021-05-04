require 'rails_helper'

RSpec.feature "Visitor logs in and is redirected to home page", type: :feature do

  # SETUP
  before :each do
    User.create!(
      first_name: 'Egg',
      last_name: 'Eggerson',
      email: 'egg@egg.com',
      password: 'egg',
      password_confirmation: 'egg'
    )
  end

  
  scenario "They log in" do
    # ACT
    visit login_path
    expect(page).to have_text 'Login/Register', count: 1
    page.fill_in :session_email, with: 'egg@egg.com'
    page.fill_in :session_password, with: 'egg'
    find('input[value="Login"]').click
    
    # DEBUG
    save_screenshot 'test_four_user_login.png'

    # VERIFY
    expect(page).to have_current_path(root_path)
    expect(page).to have_text 'Egg Eggerson', count: 1
  end
end