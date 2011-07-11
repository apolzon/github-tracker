require 'spec_helper'
describe 'Creating a new project' do
  before do
    @user = Factory :user, :password => "asdf", :password_confirmation => "asdf"
    visit '/'
    fill_in 'email', :with => @user.email
    fill_in 'password', :with => "asdf"
    click_button 'login'
    page.should have_content 'Welcome'
  end
  context 'when creating a github project' do
    it 'creates a project successfully' do
      GithubProject.count.should == 0
      visit '/projects/new'
      fill_in 'project_name', :with => 'project1'
      select 'Github Project', :from => 'project_type'
      click_button 'Save'
      page.should have_content 'Project was successfully created'
      page.should have_content 'project1'
      page.should have_content 'Github Project'
      GithubProject.count.should == 1
    end
  end
  context 'when creating a pivotal project' do
    it 'creates a project successfully' do
      PivotalProject.count.should == 0
      visit '/projects/new'
      fill_in 'project_name', :with => 'project1'
      select 'Pivotal Project', :from => 'project_type'
      click_button 'Save'
      page.should have_content 'Project was successfully created'
      page.should have_content 'project1'
      page.should have_content 'Pivotal Project'
      PivotalProject.count.should == 1
    end
  end
end
