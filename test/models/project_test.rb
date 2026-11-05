require "test_helper"

class ProjectTest < ActiveSupport::TestCase
  test "needs a name" do
    project = Project.new
    assert_not project.valid?
    assert_includes project.errors[:name], "can't be blank"
  end
end
