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
      pivotal.api_token = "asdf"
      pivotal.save
      Project.count.should == 1
      Project.first.type.should == 'PivotalProject'
      PivotalProject.count.should == 1
    end
  end

  context "creation" do
    context "with api key" do
      context "and username and password" do
        let(:project) { PivotalProject.new(:user => Factory(:user), :api_token => "asdf", :username => "asdf", :password => "asdf") }
        it "fails validation" do
          project.save.should be_false
          project.errors[:username].should be_present
          project.errors[:password].should be_present
        end
      end
      context "without username and password" do
        let(:project) { PivotalProject.new(:user => Factory(:user), :api_token => "asdf") }
        it "passes validation" do
          project.save.should be_true
        end
        it "doesn't try to fetch an api key" do
          PivotalProject.any_instance.expects(:fetch_api_token).never
          project.save
        end
      end
    end
    context "without api key" do
      context "with username and password" do
        let(:project) { PivotalProject.new(:user => Factory(:user), :username => "asdf", :password => "asdf") }
        it "passes validation" do
          project.save.should be_true
        end
        it "fetches an api key" do
          PivotalProject.any_instance.expects(:fetch_api_token)
          project.save
        end
      end
      context "without username and password" do
        let(:project) { PivotalProject.new }
        it "fails validation" do
          project.save.should be_false
          project.errors[:username].should include "must be set if api token is blank"
          project.errors[:password].should include "must be set if api token is blank"
          project.errors[:api_token].should include "must be set if username and password are blank"
        end
      end
    end
  end

  context "update" do
    it "does not allow removal of api token" do
      project = PivotalProject.create!(:user => Factory(:user), :api_token => "asdf")
      project.api_token = nil
      project.save.should be_false
      project.errors[:api_token].should include "cannot remove api token"
    end
  end

  describe "#fetch_api_token" do
    context "with valid username and password" do
      it "saves the api token" do
        pending "setup pivotal-tracker calls"
      end
    end
  end
end
