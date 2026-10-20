puts "Hello from Ruby#{RUBY_VERSION}"

#Answer day 1 check: Why is "is this user logged in?" not an authorisation check?
# Because it is an authentication check; it's not checking what the user has access to, but instead checking whether or not they are signed in to an account.

#Answer day 2 check: What should can? return for an unknown role or action, and why is the opposite answer dangerous?
# can? will return false for an unknown role or action. it would be dangerous if it were the opposite because rbacs should deny by default.

