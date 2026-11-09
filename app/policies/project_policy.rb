class ProjectPolicy < ApplicationPolicy
  def show? = role_allows?(:read, :project, record)
  def create? = true
  def update? = role_allows?(:update, :project, record)
  def destroy? = role_allows?(:delete, :project, record)
  def create_task? = role_allows?(:create, :task, record)
  def show_members? = role_allows?(:read, :members, record)
  def manage_members? = role_allows?(:manage, :members, record)
  def assign_any_role? = owner_of?(record)

  class Scope < ApplicationPolicy::Scope
    def resolve
      scope.where(id: user.memberships.select(:project_id))
    end
  end
end
