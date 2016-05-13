# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

puts 'Seeding database'

puts 'Adding admins'
k = User.new(nickname: 'koroeskohr', email: 'somebodywas@gmail.com', password: 'azerazer', password_confirmation: 'azerazer', role: User.roles[:administrator], tos: true)
k.skip_confirmation!
k.save!

puts 'Adding categories'
c1 = Category.create!(name: 'None')
c1 = Category.create!(name: 'Vipperloid')

puts 'Adding voice characteristics'
vc1 = VoiceCharacteristic.create!(name: 'Breathy')
vc2 = VoiceCharacteristic.create!(name: 'Whisper')
vc3 = VoiceCharacteristic.create!(name: 'Robotic')
vc4 = VoiceCharacteristic.create!(name: 'Childish')
vc5 = VoiceCharacteristic.create!(name: 'Low')
vc6 = VoiceCharacteristic.create!(name: 'Calm')
vc7 = VoiceCharacteristic.create!(name: 'Bright')
vc8 = VoiceCharacteristic.create!(name: 'Falsetto')
vc9 = VoiceCharacteristic.create!(name: 'Light')

puts 'Adding voicebank types'
t1 = VoicebankType.create!(name: 'CV')
t2 = VoicebankType.create!(name: 'VCV')
t3 = VoicebankType.create!(name: 'VCCV')
t4 = VoicebankType.create!(name: 'Other')

puts 'Adding voice languages'
l2 = VoiceLanguage.create!(name: 'Japanese')
l3 = VoiceLanguage.create!(name: 'English')
l1 = VoiceLanguage.create!(name: 'Chinese')
l4 = VoiceLanguage.create!(name: 'Other')

puts 'Creating homepage'
Homepage.create