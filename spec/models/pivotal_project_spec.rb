require 'spec_helper'

describe PivotalProject do
  context "sti tests" do
    it "adheres to project validations" do
      pivotal = PivotalProject.new
      pivotal.save.should be_false
      pivotal.errors[:user].should be_present
    end
    it "creates a row in the projects table" do
      Project.count.should == 0
      PivotalProject.count.should == 0
      u = Factory :user
      pivotal = PivotalProject.new
      pivotal.user = u
      pivotal.save
      Project.count.should == 1
      Project.first.type.should == 'PivotalProject'
      PivotalProject.count.should == 1
    end
  end
end
