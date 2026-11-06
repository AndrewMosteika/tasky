# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
users = %w[owner admin member viewer].index_with do |name|
  User.find_or_create_by!(email_address: "#{name}@tasky.test") do |user|
    user.password = "password-for-dev"
  end
end

project = Project.find_or_create_by!(name: "Website relaunch")
users.each do |role, user|
  project.memberships.find_or_create_by!(user: user) { |m| m.role = role }
end
project.tasks.find_or_create_by!(title: "Homepage copy") do |task|
  task.creator = users["owner"]
end