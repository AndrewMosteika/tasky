class Membership < ApplicationRecord
  belongs_to :user
  belongs_to :project

  enum :role, { viewer: 0, member: 1, admin: 2, owner: 3 }, validate: true

  validates :user_id, uniqueness: { scope: :project_id }
  validate :project_keeps_an_owner, on: :update
  before_destroy :ensure_not_last_owner

  private

  def last_owner?
    project.memberships.owner.count == 1
  end

  def project_keeps_an_owner
    return unless owner? && role_was == "owner" && last_owner?

    errors.add(:role, "can't change: a project needs at least one owner")
  end

  def ensure_not_last_owner
    return if destroyed_by_association # the whole project is being deleted
    return unless owner? && last_owner?

    errors.add(:base, "The last owner can't leave the project")
    throw :abort
  end
end
