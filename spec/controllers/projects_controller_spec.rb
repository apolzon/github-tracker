require 'spec_helper'

def stub_login_user
  @user = Factory.build :user, :id => 1
  controller.stubs(:current_user => @user)
end
describe ProjectsController do
  render_views

  describe "#index" do
    it "assigns all projects as @projects" do
      stub_login_user
      project = Factory.build(:project, {:user => @user, :id => 1})
      Project.expects(:for_user).returns(mock(:all => [project]))
      get :index
      assigns(:projects).should == [project]
      response.body.should match /#{project.name}/
      response.body.should match /#{project.url}/
    end
    it "doesn't show other user's projects" do
      user = Factory :user
      controller.stubs(:current_user => user)
      other_user = Factory :user
      my_project = Factory(:project, :user => user)
      not_my_project = Factory(:project, :user => other_user)
      controller.stubs(:current_user => user)
      get :index
      assigns(:projects).should include(my_project)
      assigns(:projects).should_not include(not_my_project)
    end
  end

  describe "#show" do
    it "assigns the requested project as @project" do
      stub_login_user
      project = Factory.build(:project, :id => 1, :user => @user)
      Project.expects(:for_user).returns(mock(:find_by_id => project))
      get :show, :id => project.to_param
      assigns(:project).should == project
      response.body.should match /#{project.name}/
      response.body.should match /#{project.url}/
    end
    it "doesn't display projects I can't access" do
      user = Factory(:user)
      controller.stubs(:current_user => user)
      other_user = Factory(:user)
      not_my_project = Factory(:project, :user => other_user)
      get :show, :id => not_my_project.to_param
      response.should be_redirect
    end
  end

  describe "#new" do
    it "assigns a new project as @project" do
      stub_login_user
      get :new
      assigns(:project).should be_a_new(Project)
    end
  end

  describe "#edit" do
    it "assigns the requested project as @project" do
      stub_login_user
      project = Factory.build(:project, :id => 1, :user => @user)
      Project.expects(:for_user).returns(mock(:find_by_id => project))
      get :edit, :id => project.to_param
      assigns(:project).should == project
      response.body.should match /#{project.name}/
      response.body.should match /#{project.url}/
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Project" do
        stub_login_user
        expect {
          post :create, :project => Factory.build(:project).attributes
        }.to change(Project.for_user(@user), :count).by(1)
        assigns(:project).should be_a(Project)
        assigns(:project).should be_persisted
        assigns(:project).user.should == @user
        response.should redirect_to(Project.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved project as @project and re-renders the form" do
        stub_login_user
        Project.any_instance.stubs(:save).returns(false)
        post :create, :project => {}
        assigns(:project).should be_a_new(Project)
        response.should render_template(:new)
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested project" do
        stub_login_user
        project = Factory.build(:project, :id => 1, :user => @user)
        find_mock = mock()
        find_mock.expects(:find_by_id).with(project.to_param).returns(project)
        Project.expects(:for_user).returns(find_mock)
        project.expects(:update_attributes).with({'these' => 'params'}).returns(true)
        put :update, :id => project.to_param, :project => {'these' => 'params'}
        assigns(:project).should == project
        assigns(:project).user.should == @user
        response.should redirect_to(project)
      end
      it "does not allow updating another users project" do
        user = Factory :user
        other_user = Factory :user
        not_my_project = Factory :project, :user => other_user
        put :update, :id => not_my_project.to_param, :project => {'name' => 'changeme'}
        response.should_not be_success
      end
    end

    describe "with invalid params" do
      it "assigns the project as @project" do
        stub_login_user
        project = Factory.build(:project, :id => 1, :user => @user)
        find_mock = mock()
        find_mock.expects(:find_by_id).with(project.to_param).returns(project)
        Project.expects(:for_user).returns(find_mock)
        project.expects(:save).returns(false)
        put :update, :id => project.to_param, :project => {}
        assigns(:project).should == project
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested project" do
      stub_login_user
      project = Factory :project, :user => @user
      expect {
        delete :destroy, :id => project.to_param
      }.to change(Project.for_user(@user), :count).by(-1)
      response.should redirect_to(projects_url)
    end
    it "doesn't allow deleting other user's projects" do
      user = Factory.build(:user, :id => 1)
      other_user = Factory.build(:user, :id => 2)
      project = Factory :project, :user => other_user
      expect { 
        delete :destroy, :id => project.to_param
      }.to change(Project.all, :count).by(0)
      response.should_not be_success
    end
  end

end
