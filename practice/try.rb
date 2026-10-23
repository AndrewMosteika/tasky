require_relative "lib/user"
require_relative "lib/authorizer"

ana = User.new("Ana", :admin)
vera = User.new("Vera", :viewer)
authorizer = Authorizer.new

puts authorizer.can?(ana, :delete, :task)
puts authorizer.can?(vera, :delete, :task)
puts "#{ana.name} is an #{ana.role}"
