class Membership < ApplicationRecord
  belongs_to :user
  belongs_to :project
  
  enum :role, { viewer: 0, member: 1, admin: 2, owner: 3 }, validate: true

  validates :user_id, uniqueness: { scope: :project_id }
end
