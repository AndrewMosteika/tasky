require relative "lib/user"
require relative "lib/authorizer"

ana = User.new("Ana", :admin)
vera = user.new("Vera", :viewer)
authorizer = Authorizer.new

puts authorizer.can?(ana, :delete, :task)
puts authorizer.can?(vera, :delete, :task)
puts "#{ana.name} is an #{ana.role}"
