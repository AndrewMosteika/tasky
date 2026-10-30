tasks = [
  { title: "Clean floor:", status: :done },
  { title: "give cat food", status: :done },
  { title: "groom cat", status: :todo },
  { title: "clean litter box", status: :todo },
  { title: "play with robert", status: :todo }
]
todo = tasks.select { |task| task[:status] == :todo }
done = tasks.count { |task| task[:status] == :done }
todo.each do |task|
  puts task[:title]
end
puts "You have #{done} tasks done out of #{tasks.count} tasks."
