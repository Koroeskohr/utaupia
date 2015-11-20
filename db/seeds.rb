# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

puts 'Seeding database'

puts 'Adding users'
10.times do
  User.create!(nickname: Faker::Name.name, email: Faker::Internet.email, password: 'helloaaa', password_confirmation: 'helloaaa')
end

puts 'Adding admins'
User.create!(nickname: 'admin', email: 'admin@admin.com', password: 'adminadmin', password_confirmation: 'adminadmin', role: User.roles[:administrator])

puts 'Adding utauloids'
10.times do
	utauloid = Utauloid.create(name: Faker::Name.name, age: rand(5..80), gender: ['male', 'female'].sample)
	utauloid.user = User.first
	utauloid.save!
end