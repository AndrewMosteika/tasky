require "test_helper"

class MembershipPolicyTest < ActiveSupport::TestCase
  test "admin cannot promote a member to owner" do
    membership = memberships(:member)
    membership.role = "owner"
    assert_not MembershipPolicy.new(users(:admin), membership).update?
  end

  test "admin can promote a viewer to member" do
    membership = memberships(:viewer)
    membership.role = "member"
    assert MembershipPolicy.new(users(:admin), membership).update?
  end

  test "admin cannot demote the owner" do
    membership = memberships(:owner)
    membership.role = "member"
    assert_not MembershipPolicy.new(users(:admin), membership).update?
  end

  test "admin cannot remove the owner" do
    policy = MembershipPolicy.new(users(:admin), memberships(:owner))
    assert_not policy.destroy?
  end

  test "admin can remove a member" do
    policy = MembershipPolicy.new(users(:admin), memberships(:member))
    assert policy.destroy?
  end

  test "admin cannot change their own role" do
    membership = memberships(:admin)
    membership.role = "viewer"
    assert_not MembershipPolicy.new(users(:admin), membership).update?
  end

  test "owner can make someone an admin" do
    membership = memberships(:member)
    membership.role = "admin"
    assert MembershipPolicy.new(users(:owner), membership).update?
  end

  test "member cannot manage anyone" do
    membership = memberships(:viewer)
    policy = MembershipPolicy.new(users(:member), membership)
    assert_not policy.destroy?

    membership.role = "member"
    assert_not policy.update?
  end
end
