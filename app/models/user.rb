class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy
  has_many :memberships, dependent: :destroy
  has_many :projects, through: :memberships

  normalizes :email_address, with: ->(e) { e.strip.downcase }
  validates :email_address, presence: true, uniqueness: true
  validates :password, length: { minimum: 10 }, allow_nil: true
  def role_in(project)
    memberships.find_by(project: project)&.role
  end
end
