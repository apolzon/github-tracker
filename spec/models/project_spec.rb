require 'spec_helper'

describe Project do
  it "requires a user" do
    project = Factory.build :project
    project.user = nil
    expect {
      project.save!
    }.to raise_error
  end
  it "saves successfully with a user" do
    project = Factory.build :project
    user = Factory :user
    project.user = user
    project.save!
    User.find(user.id).projects.should == [project]
  end

  describe ".for_user" do
    it "only returns projects the user owns" do
      user = Factory :user
      other_user = Factory :user
      my_project = Factory :project, :user => user
      not_my_project = Factory :project, :user => other_user

      Project.for_user(user).all.should include(my_project)
      Project.for_user(user).all.should_not include(not_my_project)
      Project.for_user(other_user).all.should include(not_my_project)
      Project.for_user(other_user).all.should_not include(my_project)
    end
  end
  describe '.select_options' do
    it "returns an appropriate array containing all subclasses" do
      options = Project.select_options
      options.should include(['Pivotal Project', 'PivotalProject'])
      options.should include(['Github Project', 'GithubProject'])
    end
  end
end
