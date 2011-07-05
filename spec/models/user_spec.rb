require 'spec_helper'

describe User do
  it "has projects" do
    user = Factory :user
    project = Factory :project
    user.projects << project
    user.save!
    User.find(user.id).projects.should == [project]
  end
  it "encrypts the users password" do
    user = Factory :user, :password => "asdf"
    user.password.should == "asdf"
    user.password_digest.should_not be_blank
    user.authenticate("asdf").should be_true
  end
end
