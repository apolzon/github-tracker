require 'spec_helper'

describe GithubProject do
  context "sti tests" do
    it "adheres to project validations" do
      gh = GithubProject.new
      gh.save.should be_false
      gh.errors[:user].should be_present
    end
    it "creates a row in the projects table" do
      Project.count.should == 0
      GithubProject.count.should == 0
      u = Factory :user
      gh = GithubProject.new
      gh.user = u
      gh.save
      Project.count.should == 1
      Project.first.type.should == 'GithubProject'
      GithubProject.count.should == 1
    end
  end
end
