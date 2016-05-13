require 'csv'

namespace :utauloids do
  desc "Import cvs"
  task import_csv: :environment do
		begin
			csv_file = File.read(File.join(Rails.root, "db", "utauloids.csv"))
		rescue
			raise 'Error while loading the csv utauloids.csv'
		end

		# Downcase headers and Remove whitespace 
		csv = CSV.parse(csv_file, headers: true, header_converters: lambda {|f| f.downcase.strip})

		i = 0
		user = User.first

		csv.each do |row|
			i = i + 1
			puts "#{i} - #{row['name']}"
			u =	Utauloid.new()
			u.name = row['name'] unless row['name'].blank?
			u.name = row['japanese_name'] unless row['japanese_name'].blank?
			u.gender = row['gender'].downcase unless row['gender'].blank?
			u.creator_name = row['creator_name'] unless row['creator_name'].blank?
			u.creator_is_user = row['creator_name'].blank?
			u.vb_release_date = Date.parse(row['vb_release_date']) unless row['vb_release_date'].blank?
			if row['vb_last_update'].blank?
				u.vb_last_update = Date.parse(row['vb_release_date']) unless row['vb_release_date'].blank?
			else
				u.vb_last_update = Date.parse(row['vb_last_update']) unless row['vb_last_update'].blank?
			end
			if !row['cover'].blank?
				img = open(URI.parse(URI.encode(row['cover'].strip)))

				u.avatar = img unless i.nil?
				u.cover = img unless i.nil?
			end
			u.voice_languages << VoiceLanguage.where(name: row['voice_languages'].split('/').map(&:capitalize)) unless row['voice_languages'].blank?
			u.voicebank_types << VoicebankType.where(name: row['voicebank_types'].split('/')) unless row['voicebank_types'].blank?
			u.voice_characteristics << VoiceCharacteristic.where(name: row['voice_characteristics'].split('/').map(&:capitalize)) unless row['voice_characteristics'].blank?
			u.creator = user

			u.save
		end

		puts 'End'
  end
end
