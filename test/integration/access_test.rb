require "test_helper"

class AccessTest < ActionDispatch::IntegrationTest
  setup { @project = projects(:relaunch) }

  test "signed-out visitors are sent to sign in" do
    get project_path(@project)
    assert_redirected_to new_session_path
  end

  test "a viewer cannot edit a task by sending the request directly" do
    sign_in_as users(:viewer)
    task = tasks(:homepage)
    patch project_task_path(@project, task),
      params: { task: { title: "Hacked" } }
    assert_redirected_to root_path
    assert_equal "Homepage copy", task.reload.title
  end

  test "an outsider gets 404 for the project" do
    sign_in_as users(:outsider)
    get project_path(@project)
    assert_response :not_found
  end

  test "a task can't be reached through the wrong project" do
    sign_in_as users(:owner)
    get project_task_path(@project, tasks(:side_task))
    assert_response :not_found
  end

  test "an admin cannot make themselves owner" do
    sign_in_as users(:admin)
    patch project_membership_path(@project, memberships(:admin)),
      params: { membership: { role: "owner" } }
    assert_equal "admin", memberships(:admin).reload.role
  end

  test "a task can't be assigned to someone outside the project" do
    sign_in_as users(:owner)
    task = tasks(:homepage)
    patch project_task_path(@project, task),
      params: { task: { assignee_id: users(:outsider).id } }
    assert_response :unprocessable_content
    assert_nil task.reload.assignee
  end

  test "creating a project makes you its owner" do
    sign_in_as users(:outsider)
    post projects_path, params: { project: { name: "New thing" } }
    assert_equal "owner", users(:outsider).role_in(Project.last)
  end

  test "an admin cannot remove the owner through the members page" do
    sign_in_as users(:admin)
    assert_no_difference "Membership.count" do
      delete project_membership_path(@project, memberships(:owner))
    end
    assert_redirected_to root_path
  end

  test "a member cannot delete a task" do
    sign_in_as users(:member)
    assert_no_difference "Task.count" do
      delete project_task_path(@project, tasks(:homepage))
    end
    assert_redirected_to root_path
  end
end
