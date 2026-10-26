# Exercise 2: turn a score into a letter grade
score = 72

grade = if score >= 90
  "A"
elsif score >= 70
  "B"
elsif score >= 50
  "C"
else
  "F"
end

puts grade
