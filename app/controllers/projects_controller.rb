class ProjectsController < ApplicationController
  before_action :set_project, only: %i[show edit update destroy]

  def index
    @projects = policy_scope(Project).order(:name)
  end

  def show
  end

  def new
    @project = authorize Project.new
  end

  def create
    @project = authorize Project.new(project_params)
    @project.memberships.build(user: Current.user, role: :owner)
    if @project.save
      redirect_to @project, notice: "Project created."
    else
      render :new, status: :unprocessable_content
    end
  end

  def edit
  end

  def update
    if @project.update(project_params)
      redirect_to @project, notice: "Project updated."
    else
      render :edit, status: :unprocessable_content
    end
  end

  def destroy
    @project.destroy
    redirect_to projects_path, notice: "Project deleted.", status: :see_other
  end

  private

  def set_project
    @project = authorize policy_scope(Project).find(params[:id])
  end

  def project_params
    params.expect(project: [ :name, :description ])
  end
end
