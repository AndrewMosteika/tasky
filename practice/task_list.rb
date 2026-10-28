def shout(text)
  text.upcase + "!"
end
class Task
  attr_reader :title, :status # creates title and status reader methods
  def initialize(title) # runs when you call Task.new
    @title = title # @ = instance variable, kept by this object
    @status = :todo
  end
  def complete!
    @status = :done
  end
  def done?
    @status == :done
  end
end

class TaskList
  def initialize
    @tasks = []
  end
  def add(task)
    @tasks << task
  end
  def pending
    @tasks.select { |task| task.status == :todo }
  end
  def summary
    done = @tasks.count { |task| task.status == :done }
    "#{done} of #{@tasks.count} done"
  end
end

task1 = Task.new("Clean floor")
task2 = Task.new("Give cat food")
task3 = Task.new("Groom cat")

task1.complete!
List = TaskList.new
List.add(task1)
List.add(task2)
List.add(task3)

puts List.pending.map(&:title)
puts List.summary