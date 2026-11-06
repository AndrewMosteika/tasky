# What each project role may do. Anything not listed is denied.
module Permissions
  MATRIX = {
    "viewer" => {
      project: %i[read],
      task: %i[read],
      members: %i[read]
    },
    "member" => {
      project: %i[read],
      task: %i[read create update],
      members: %i[read]
    },
    "admin" => {
      project: %i[read update],
      task: %i[read create update delete],
      members: %i[read manage]
    },
    "owner" => {
      project: %i[read update delete],
      task: %i[read create update delete],
      members: %i[read manage]
    }
  }.freeze

  def self.allows?(role, action, resource)
    actions = MATRIX.dig(role, resource) || []
    actions.include?(action)
  end
end
