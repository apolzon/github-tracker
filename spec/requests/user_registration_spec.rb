require 'spec_helper'

describe 'User Registration' do
  context 'with valid params' do
    it "succeeds" do
      visit '/registrations/new'
      fill_in 'user_email', :with => 'myemail'
      fill_in 'user_name', :with => 'myname'
      fill_in 'user_password', :with => 'asdf'
      fill_in 'user_password_confirmation', :with => 'asdf'
      click_button 'register'
      page.should have_content 'Registered successfully. Please login.'
      current_url.should match 'auth'
    end
  end
  context 'with invalid params' do
    before do
      visit '/registrations/new'
    end
    it 'gives single error message for already taken email address' do
      Factory(:user, :email => 'taken')
      fill_in 'user_email', :with => 'taken'
      fill_in 'user_name', :with => 'myname'
      fill_in 'user_password', :with => 'asdf'
      fill_in 'user_password_confirmation', :with => 'asdf'
      click_button 'register'
      page.should have_content 'E-mail already taken'
      current_url.should match 'auth'
    end
    it 'renders error messages for other validation errors' do
      click_button 'register'
      page.should have_content "Name can't be blank"
      page.should have_content "Email can't be blank"
      page.should have_content "Password can't be blank"
      current_url.should match 'registrations'
    end
    it 'renders error message for non matching passwords' do
      fill_in 'user_password', :with => 'asdf'
      fill_in 'user_password_confirmation', :with => 'asd'
      click_button 'register'
      page.should have_content "Password doesn't match confirmation"
    end
  end
end
