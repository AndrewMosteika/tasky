require "test_helper"

class MembershipTest < ActiveSupport::TestCase
  test "the last owner cannot be demoted" do
    membership = memberships(:owner)
    assert_not membership.update(role: "admin")
    assert_includes membership.errors[:role],
      "can't change: a project needs at least one owner"
  end

  test "the last owner cannot leave" do
    assert_not memberships(:owner).destroy
    assert Membership.exists?(memberships(:owner).id)
  end

  test "an owner can be demoted when another owner exists" do
    memberships(:admin).update!(role: "owner")
    assert memberships(:owner).update(role: "admin")
  end

  test "deleting the project still works" do
    project = projects(:relaunch)
    assert project.destroy
    assert_not Membership.exists?(project_id: project.id)
  end
end
