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
vc1 = VoiceCharacteristic.create!(name: 'Soft')

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


utauloid = Utauloid.new(name: "Test buddy",
     vb_release_date: (rand*10).days.ago,
     vb_last_update: (rand*8).days.ago,
     voice_languages: [l1, l2],
     voicebank_types: [t1, t3],
     gender: 'male',
     creator_name: "Oui",
     creator_is_user: false)
utauloid.creator_id = User.first.id

utauloid.save!


puts 'Creating homepage'
Homepage.create