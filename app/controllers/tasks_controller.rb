class TasksController < ApplicationController
  before_action :set_project
  before_action :set_task, only: %i[show edit update destroy]

  def show
  end

  def new
    @task = @project.tasks.new
  end

  def create
    @task = @project.tasks.new(task_params)
    @task.creator = Current.user
    if @task.save
      redirect_to @project, notice: "Task created."
    else
      render :new, status: :unprocessable_content
    end
  end

  def edit
  end

  def update
    if @task.update(task_params)
      redirect_to @project, notice: "Task updated."
    else
      render :edit, status: :unprocessable_content
    end
  end

  def destroy
    @task.destroy
    redirect_to @project, notice: "Task deleted.", status: :see_other
  end

  private

  def set_project
    @project = Project.find(params[:project_id])
  end

  def set_task
    @task = @project.tasks.find(params[:id])
  end

  def task_params
    params.expect(task: [ :title, :description, :status, :due_on ])
  end
end
