require 'rails_helper'
require 'spec_helper'

RSpec.feature 'EventsManagements', type: :feature do
  before :each do
    @user = User.create(username: 'creator',
                        email: 'test@test.com',
                        password: 'foobar',
                        password_confirmation: 'foobar')
  end

  it 'User login and event creation' do
    visit '/auth/users/sign_in'
    fill_in 'user_email', with: @user.email
    fill_in 'user_password', with: @user.password
    click_button 'Log in'
    expect(page).to have_content 'Signed in successfully.'
    visit root_path
    expect(page).to have_content 'Logout'
    click_link 'New post'
    expect(page).to have_field 'Content'
    fill_in 'post_content', with: 'some weird post'
    click_button 'Create Post'
    expect(page).to have_content 'Post was successfully created.'
  end

  it 'Not Logged in user' do
    visit '/auth/users/sign_in'
    fill_in 'user_email', with: 'tdfdd@dfdf.com'
    click_button 'Log in'
    expect(page).to have_content 'Invalid Email or password.'
  end
end
