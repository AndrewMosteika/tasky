roles = { "admin" => 3, viewer: 0}
puts roles["admin"]
puts roles[:admin.to_s]
puts roles["viewer".to_sym]
puts roles[:viewer]

