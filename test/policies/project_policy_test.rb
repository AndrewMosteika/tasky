require "test_helper"

class ProjectPolicyTest < ActiveSupport::TestCase
  # Typed out by hand from docs/rbac.md, on purpose: if this read
  # Permissions::MATRIX, a mistake in the matrix would pass its own test.
  EXPECTED = {
    viewer: {
      show?: true, update?: false, destroy?: false, create_task?: false,
      show_members?: true, manage_members?: false, assign_any_role?: false
    },
    member: {
      show?: true, update?: false, destroy?: false, create_task?: true,
      show_members?: true, manage_members?: false, assign_any_role?: false
    },
    admin: {
      show?: true, update?: true, destroy?: false, create_task?: true,
      show_members?: true, manage_members?: true, assign_any_role?: false
    },
    owner: {
      show?: true, update?: true, destroy?: true, create_task?: true,
      show_members?: true, manage_members?: true, assign_any_role?: true
    },
    outsider: {
      show?: false, update?: false, destroy?: false, create_task?: false,
      show_members?: false, manage_members?: false, assign_any_role?: false
    }
  }

  EXPECTED.each do |person, permissions|
    permissions.each do |action, allowed|
      test "#{person} #{allowed ? 'can' : 'cannot'} #{action}" do
        policy = ProjectPolicy.new(users(person), projects(:relaunch))
        assert_equal allowed, policy.public_send(action)
      end
    end
  end

  test "any signed-in user can create a project" do
    assert ProjectPolicy.new(users(:outsider), Project.new).create?
  end
end
