class MembershipPolicy < ApplicationPolicy
  LOWER_ROLES = %w[viewer member].freeze

  def create? = manage?
  def update? = manage?
  def destroy? = manage?

  class Scope < ApplicationPolicy::Scope
    def resolve
      scope.where(project_id: user.memberships.select(:project_id))
    end
  end

  private

  # Owners manage anyone. Admins only manage Viewers and Members,
  # judged on the role before AND after the change.
  def manage?
    return false unless role_allows?(:manage, :members, record.project)
    return true if owner_of?(record.project)

    [ record.role_was, record.role ].all? { |role| LOWER_ROLES.include?(role) }
  end
end
