require "minitest/autorun"
require_relative "lib/user"
require_relative "lib/authorizer"

class AuthorizerTest < Minitest::Test
  def setup
    @authorizer = Authorizer.new
  end

  def test_viewer_cannot_delete_tasks
    vera = User.new("Vera", :viewer)
    refute @authorizer.can?(vera, :delete, :task)
  end

  def test_unknown_role_is_denied
    ghost = User.new("Ghost", :wizard)
    refute @authorizer.can?(ghost, :read, :task)
  end

  def test_viewer_can_read_tasks
    robert = User.new("Robert", :viewer)
    assert @authorizer.can?(robert, :read, :task)
  end

  def test_member_can_create_projects
    pikachu = User.new("Pikachu", :member)
    refute @authorizer.can?(pikachu, :create, :project)
  end

  def test_admin_cannot_delete_projects
    pete = User.new("Pete", :admin)
    refute @authorizer.can?(pete, :delete, :project)
  end

  def test_admin_cannot_update_projects
    aragorn = User.new("Aragorn", :admin)
    assert @authorizer.can?(aragorn, :update, :project)
  end
end
