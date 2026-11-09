class TaskPolicy < ApplicationPolicy
  def show? = role_allows?(:read, :task, record.project)
  def create? = role_allows?(:create, :task, record.project)
  def update? = role_allows?(:update, :task, record.project)
  def destroy? = role_allows?(:delete, :task, record.project)
end
