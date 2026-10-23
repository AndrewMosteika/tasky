puts "Hi from Ruby #{RUBY_VERSION}"

#Answer day 1 check: Why is "is this user logged in?" not an authorisation check?
# Because it is an authentication check; it's not checking what the user has access to, but instead checking whether or not they are signed in to an account.

#Answer day 2 check: What should can? return for an unknown role or action, and why is the opposite answer dangerous?
# can? will return false for an unknown role or action. it would be dangerous if it were the opposite because rbacs should deny by default.

#Answer day 3 check: What breaks if a user can only ever have one role? Think of someone who is an Admin in one team and a Viewer in another.
# If a user can only have one role universally, many issues would ensue. Lets say Will is a viewer of team A and an admin on team B. If you give him admin, he will have too much access in team A and not enough in team B.
