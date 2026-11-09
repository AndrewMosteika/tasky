class MembershipsController < ApplicationController
  before_action :set_project
  before_action :set_membership, only: %i[update destroy]

  def index
    @memberships = policy_scope(@project.memberships).includes(:user).order(:role)
  end

  def create
    user = User.find_by(email_address: params[:email_address])
    @membership = @project.memberships.new(user: user, role: params[:role])
    authorize @membership
    save_and_redirect(@membership.save, "Member added.")
  end

  def update
    @membership.assign_attributes(params.expect(membership: [ :role ]))
    authorize @membership
    save_and_redirect(@membership.save, "Role updated.")
  end

  def destroy
    authorize @membership
    save_and_redirect(@membership.destroy, "Member removed.")
  end

  private

  def set_project
    @project = policy_scope(Project).find(params[:project_id])
  end

  def set_membership
    @membership = @project.memberships.find(params[:id])
  end

  def save_and_redirect(ok, message)
    if ok
      redirect_to project_memberships_path(@project), notice: message
    else
      redirect_to project_memberships_path(@project),
        alert: @membership.errors.full_messages.to_sentence
    end
  end
end