# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

puts 'Seeding database'

user_count = 0

puts 'Adding users and UserInfo'
10.times do |i|
	user_count += 1
  User.create!(nickname: Faker::Name.name, email: Faker::Internet.email, password: 'helloaaa', password_confirmation: 'helloaaa')
  UserInfo.create!(user_id: user_count)
end

puts 'Adding admins'
user_count += 1
User.create!(nickname: 'administrator', email: 'admin@admin.com', password: 'adminadmin', password_confirmation: 'adminadmin', role: User.roles[:administrator])
UserInfo.create!(user_id: user_count)

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
  creator_name = [nil, "someone"].sample
	utauloid = Utauloid.new(name: Faker::Name.name, 
       gender: ['male', 'female', 'undefined', 'other'].sample,
       creator_name: creator_name,
       creator_is_user: creator_name.nil?)
	utauloid.creator = User.first
  utauloid.save!
  2.times do
    comment = UtauloidComment.new(user_id: 1, utauloid_id: utauloid.id, message: "That an awesome Utauloid !")
    utauloid.utauloid_comments << comment
  end
  [l1, l2].sample.utauloids << utauloid
  [c1, c2].sample.utauloids << utauloid
  [vc1, vc2].sample.utauloids << utauloid
  [t1, t2, t3].sample.utauloids << utauloid
end