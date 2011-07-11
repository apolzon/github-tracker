class ProjectsController < ApplicationController
  def index
    @projects = Project.for_user(current_user).all

    respond_to do |format|
      format.html # index.html.haml
      format.json { render json: @projects }
    end
  end

  def show
    @project = Project.for_user(current_user).find_by_id(params[:id])
    redirect_to '/auth/not_authorized' and return unless @project

    respond_to do |format|
      format.html # show.html.haml
      format.json { render json: @project }
    end
  end

  def new
    @project = Project.new

    respond_to do |format|
      format.html # new.html.haml
      format.json { render json: @project }
    end
  end

  def edit
    @project = Project.for_user(current_user).find_by_id(params[:id])
    redirect_to '/auth/not_authorized' and return unless @project
  end

  def create
    if params[:project][:type]
      @project = params[:project][:type].constantize.new params[:project]
    else
      @project = Project.new params[:project]
    end

    respond_to do |format|
      if @project.save
        format.html { redirect_to @project, notice: 'Project was successfully created.' }
        format.json { render json: @project, status: :created, location: @project }
      else
        format.html { render action: "new" }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @project = Project.for_user(current_user).find_by_id(params[:id])
    redirect_to '/auth/not_authorized' and return unless @project

    if params[:project][:type] && @project.type != params[:project][:type]
      flash[:error] = "Save failed. Cannot modify existing project's type"
      render action: "edit" and return
    end

    respond_to do |format|
      if @project.update_attributes(params[:project])
        format.html { redirect_to @project, notice: 'Project was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @project = Project.for_user(current_user).find_by_id(params[:id])
    redirect_to '/auth/not_authorized' and return unless @project
    @project.destroy

    respond_to do |format|
      format.html { redirect_to projects_url }
      format.json { head :ok }
    end
  end
end
