# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

User.create!(name:  "Site Administrator",              
                 email: "admin@gmail.com",
                 password:               "zx12as",   
                 password_confirmation:  "zx12as",
                 admin:                   true)   

User.create!(name:  "Ostapenko Vitaly",
                 email: "ostapenko.vitaly@gmail.com",
                 password:               "zx12as",
                 password_confirmation:  "zx12as")

User.create!(name:  "Example User",
                 email: "example@railstutorial.org",
                 password:              "zx12as",
                 password_confirmation: "zx12as")

99.times do |n|
    name  = Faker::Name.name
    email = "example-#{n+1}@railstutorial.org"
    password = "zx12as"
    User.create!(name:  name,
                 email: email,
                 password:              password,
                 password_confirmation: password)
end
