class AssignmentsController < ApplicationController
  def index
    @tasks = policy_scope(Task).where(assignee: Current.user)
    .includes(:project).order(:due_on)
  end
end
