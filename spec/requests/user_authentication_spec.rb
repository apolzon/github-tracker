require 'spec_helper'

describe 'User Authentication' do
  context 'I have an active account' do
    it 'I can login' do
      user = Factory :user, :password => "asdf", :password_confirmation => "asdf"
      visit '/'
      fill_in 'email', :with => user.email
      fill_in 'password', :with => "asdf"
      click_button 'login'
      page.should have_content 'Welcome'
    end
  end
end
