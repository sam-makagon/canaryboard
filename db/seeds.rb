["green", "yellow", "red", "blue"].each do |color|
  Status.create(name: color)
end

User.create(name: "admin", password: "admin")
