# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

unless Role.exists?
  Role.create([ { name: 'Admin'}, { name: 'Author' }, { name: 'Moderator' } ])
end

unless User.exists?
  email = ENV.fetch('USERNAME') { 'wiki@mail.com' }
  password = ENV.fetch('PASSWORD') { 'password123' }
  user = User.create(email: email, password: password, password_confirmation: password)
  user.role = Role.find_by name: 'Admin'
end

unless Tag.exists?
  Tag.create([
    { name: 'Ruby' }, { name: 'HTML' }, { name: 'Rails' }, { name: 'CSS' }, { name: 'Javascript' },
    { name: 'JQuery' }, { name: 'Docker' }
  ])
end


