User.create! name: "admin", email: "admin@gmail.com",
  address: "dia chi", password: "admin1234", password_confirmation: "admin1234",
  admin: 1

30.times do |i|
  password = "password"
  User.create! name: "User #{i+1}", email: "account-#{i+1}@e-learning.com",
    password: "password", password_confirmation: "password",
    admin: 0
end

user  = User.first
following = User.all[2..30]
followers = User.all[3..20]
following.each do |followed|
  user.follow followed
end
