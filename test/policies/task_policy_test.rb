require "test_helper"

class TaskPolicyTest < ActiveSupport::TestCase
  # Typed out by hand from docs/rbac.md, on purpose: if this read
  # Permissions::MATRIX, a mistake in the matrix would pass its own test.
  EXPECTED = {
    viewer: { show?: true, create?: false, update?: false, destroy?: false },
    member: { show?: true, create?: true, update?: true, destroy?: false },
    admin: { show?: true, create?: true, update?: true, destroy?: true },
    owner: { show?: true, create?: true, update?: true, destroy?: true },
    outsider: {
      show?: false, create?: false, update?: false, destroy?: false
    }
  }

  EXPECTED.each do |person, permissions|
    permissions.each do |action, allowed|
      test "#{person} #{allowed ? 'can' : 'cannot'} #{action}" do
        policy = TaskPolicy.new(users(person), tasks(:homepage))
        assert_equal allowed, policy.public_send(action)
      end
    end
  end
end
