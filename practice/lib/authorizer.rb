# What each role can do, per resource
class Authorizer
  PERMISSIONS = {
    viewer: { project: [ :read ], task: [ :read ] },
    member: { project: [ :read ], task: [ :read, :create, :update ] },
    admin: {
      project: [ :read, :create, :update ],
      task: [ :read, :create, :update, :delete ]
    },
    owner: {
      project: [ :read, :create, :update, :delete ],
      task: [ :read, :create, :update, :delete ]
    }
  }

  def can?(user, action, resource)
    actions = PERMISSIONS.dig(user.role, resource) || []
    actions.include?(action)
  end
end
