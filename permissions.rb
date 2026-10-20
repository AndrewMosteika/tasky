# What each role can do, per resource
PERMISSIONS = {
  viewer: { project: [:read], task: [:read] },
  member: { project: [:read], task: [:read, :create, :update] },
  admin: {
    project: [:read, :create, :update],
    task: [:read, :create, :update, :delete]
  },
  owner: {
    project: [:read, :create, :update, :delete],
    task: [:read, :create, :update, :delete]
  }
}
def can?(role, action, resource)
    actions = PERMISSIONS.dig(role, resource)
    return false if actions.nil?
    
    actions.include?(action)
end
puts can?(:viewer, :read, :task)
puts can?(:viewer, :delete, :task)
puts can?(:member, :update, :task)
puts can?(:member, :update, :project)
puts can?(:intern, :read, :task)      
puts can?(:owner, :read, :invoice)

