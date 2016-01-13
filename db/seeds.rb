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
User.create!(nickname: 'administrator', email: 'admin@admin.com', password: 'adminadmin', password_confirmation: 'adminadmin', role: User.roles[:administrator])

puts 'Adding categories'
c1 = Category.create!(name: 'Vipperloid')
c2 = Category.create!(name: 'Pas Vipperloid')

puts 'Adding voice characteristics'
vc1 = VoiceCharacteristic.create!(name: 'Rocailleux')
vc2 = VoiceCharacteristic.create!(name: 'Léger')

puts 'Adding voicebank types'
t1 = VoicebankType.create!(name: 'cv')
t2 = VoicebankType.create!(name: 'vcv')
t3 = VoicebankType.create!(name: 'vccv')

puts 'Adding voice languages'
l1 = VoiceLanguage.create!(name: 'Chinese')
l2 = VoiceLanguage.create!(name: 'Japanese')


puts 'Adding utauloids'
10.times do
	utauloid = Utauloid.new(name: Faker::Name.name, 
       gender: ['male', 'female', 'undefined', 'other'].sample)
	utauloid.creator = User.first
  utauloid.save!
  [c1, c2].sample.utauloids << utauloid
  [l1, l2].sample.utauloids << utauloid
  [vc1, vc2].sample.utauloids << utauloid
  [t1, t2, t3].sample.utauloids << utauloid
end