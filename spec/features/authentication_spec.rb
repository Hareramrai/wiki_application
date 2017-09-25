require 'rails_helper'

RSpec.describe "Authentication", type: :feature do
  
  it "don't allow to access authenticated page without login" do
    visit articles_url

    expect(current_url).to eq(new_user_session_url)

    expect(page).to have_selector('div.alert', text: "You need to sign in or sign up before continuing.")
  end

  it "allow to access authenticated page after login" do
    user = create(:user)
    login_as(user, :scope => :user)

    visit articles_url

    expect(current_url).to eq(current_url)

    expect(page).to have_selector('h1', text: 'Articles')
  end
  
  it 'allows users to log in' do
    user = create(:user, password: 'password123', password_confirmation: 'password123')
    visit new_user_session_url
    
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: 'password123'

    click_button 'Sign in'
    
    expect(current_url).to eq(root_url)
    expect(page).to have_selector('h3', text: "Hello #{user.email}!")
  end

  it 'allows users to log out' do
    user = create(:user)
    login_as(user, :scope => :user)
    
    visit root_url
    
    click_link "#{user.email}"
    click_link 'Sign Out'
    
    expect(current_url).to eq(root_url)
    expect(page).to have_selector('div.alert', text: "Signed out successfully.")
  end


end