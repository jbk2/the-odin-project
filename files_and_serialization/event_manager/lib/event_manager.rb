require 'csv'
require "google/apis/civicinfo_v2"
require 'erb'


def clean_zipcode(zipcode)
	zipcode.to_s.rjust(5, '0')[0..4]
end

def clean_phone_number(number)
	clean_number = number.delete(' ().\-')
	length = clean_number.length

	if clean_number.match(/[A-za-z]/)
		clean_number = "dirty no"
		# puts "number contains alpha chars #{clean_number}"
	elsif length == 10
		clean_number
	elsif length == 11 && clean_number[0] == '1'
			clean_number = clean_number.delete(clean_number[0])
		# puts "10 digits and ok #{clean_number}"
	else clean_number = "dirty no"
	end
end

def legislators_by_zipcode(zipcode)
civic_info = Google::Apis::CivicinfoV2::CivicInfoService.new
civic_info.key = "AIzaSyDDRsl0E_UMtiFQ-YpNyiAipHdRijbgLbs"

	begin
		civic_info.representative_info_by_address(
			address: zipcode,
			levels: 'country',
			roles: ['legislatorUpperBody', 'legislatorLowerBody']
		).officials
	rescue
		puts 'You can find your rep by ...'
	end
end

def save_thank_you_letter(id, form_letter)
	Dir.mkdir('output') unless Dir.exist?('output')
	filename = "output/thanks_#{id}.html"
	File.open(filename, 'w') do |file|
		file.puts(form_letter)
	end
end

data_file = CSV.open(
	'event_attendees.csv',
	headers: true,
	header_converters: :symbol
)

template_letter = File.read('form_letter.erb')
erb_template = ERB.new(template_letter)

data_file.each do |row|
	name 		= row[:first_name]
	id			= row[0]
	zipcode = clean_zipcode(row[:zipcode])
	legislators = legislators_by_zipcode(zipcode)
	tel_no = clean_phone_number(row[:homephone])
	reg_date_time = row[:regdate]
	form_letter = erb_template.result(binding)

	save_thank_you_letter(id, form_letter)
end



