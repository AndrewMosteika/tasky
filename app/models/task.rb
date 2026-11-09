class Task < ApplicationRecord
  belongs_to :project
  belongs_to :creator, class_name: "User"
  belongs_to :assignee, class_name: "User", optional: true

  enum :status, { todo: 0, in_progress: 1, done: 2 }

  validates :title, presence: true
  validate :assignee_must_be_member

  private

  def assignee_must_be_member
    return if assignee.nil? || project.nil?
    return if project.memberships.exists?(user: assignee)

    errors.add(:assignee, "must be a member of this project")
  end
end
