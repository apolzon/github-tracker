require 'spec_helper'

describe ProjectsController do
  render_views

  describe "#index" do
    it "assigns all projects as @projects" do
      project = Factory.build(:project, :id => 1)
      Project.expects(:all).returns([project])
      get :index
      assigns(:projects).should == [project]
      response.body.should match /#{project.name}/
      response.body.should match /#{project.url}/
    end
  end

  describe "#show" do
    it "assigns the requested project as @project" do
      project = Factory.build(:project, :id => 1)
      Project.expects(:find).with(project.to_param).returns(project)
      get :show, :id => project.to_param
      assigns(:project).should == project
      response.body.should match /#{project.name}/
      response.body.should match /#{project.url}/
    end
  end

  describe "#new" do
    it "assigns a new project as @project" do
      get :new
      assigns(:project).should be_a_new(Project)
    end
  end

  describe "#edit" do
    it "assigns the requested project as @project" do
      project = Factory.build(:project, :id => 1)
      Project.expects(:find).with(project.to_param).returns(project)
      get :edit, :id => project.to_param
      assigns(:project).should == project
      response.body.should match /#{project.name}/
      response.body.should match /#{project.url}/
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Project" do
        expect {
          post :create, :project => Factory.build(:project).attributes
        }.to change(Project, :count).by(1)
        assigns(:project).should be_a(Project)
        assigns(:project).should be_persisted
        response.should redirect_to(Project.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved project as @project and re-renders the form" do
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
        project = Factory.build(:project, :id => 1)
        Project.expects(:find).with(project.to_param).returns(project)
        project.expects(:update_attributes).with({'these' => 'params'}).returns(true)
        put :update, :id => project.to_param, :project => {'these' => 'params'}
        assigns(:project).should == project
        response.should redirect_to(project)
      end
    end

    describe "with invalid params" do
      it "assigns the project as @project" do
        project = Factory.build(:project, :id => 1)
        Project.expects(:find).with(project.to_param).returns(project)
        project.expects(:save).returns(false)
        put :update, :id => project.to_param, :project => {}
        assigns(:project).should == project
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested project" do
      project = Factory :project
      expect {
        delete :destroy, :id => project.to_param
      }.to change(Project, :count).by(-1)
      response.should redirect_to(projects_url)
    end
  end

end
