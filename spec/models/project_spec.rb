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
end
