require "test_helper"

class TaskTest < ActiveSupport::TestCase
  test "needs a title" do
    task = Task.new(project: projects(:one))
    assert_not task.valid?
    assert_includes task.errors[:title], "can't be blank"
  end

  test "starts as to do" do
    assert Task.new.todo?
  end
end
