require 'spec_helper'

describe User do
  it "has projects" do
    user = Factory :user
    project = Factory :project
    user.projects << project
    user.save!
    User.find(user.id).projects.should == [project]
  end
end
