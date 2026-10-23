# Exercise 1: greet someone with their rough age
name = "Andrew"
birth_year = 1995 # change to your own

age = Time.now.year - birth_year
puts "Hi #{name}, you are about #{age}"
