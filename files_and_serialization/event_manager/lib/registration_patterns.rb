require 'csv'
require 'time'
require 'pry-byebug'

def log_reg_data
	# pull in reg date data
	# tabulate frequency of registrations per hour of clock in html file

end

source_data = CSV.open('event_attendees.csv',
	headers: true,
	header_converters: :symbol
)

times_array = []
days_array = []
file_name = 'output/reg_stats.txt'
time_count_hash = {}
time_count_string = time_count_hash.to_s
day_count_hash = {
	Monday: 0,
	Tuesday: 0,
	Wednesday: 0,
	Thursday: 0,
	Friday: 0,
	Saturday: 0,
	Sunday: 0
}


def collect_hour(input, output)
	input.each do |row|
		time_object = Time.strptime(row[:regdate], '%m/%d/%y %H:%M')
		hour = time_object.hour
		output << hour
	end
	output
end

def collect_day(input, output)
	input.each do |row|
		time_object = Time.strptime(row[:regdate], '%m/%d/%y %H:%M')
		day = time_object.strftime('%A')
		puts day
		output << day
	end
	output
end

def hour_frequency(times_array, time_count_hash)
	Array(1..24).each do |i|
		time_count_hash[i] = times_array.count(i)
	end
end

def day_frequency(days_array, day_count_hash)
	days_array.each do |day|
		day_count_hash[day.to_sym] += 1
	end
	puts day_count_hash
end

def save_hour_to_file(file_name, data)
	File.open(file_name, 'a') do |file|
		data.each do |key, value|
			file.puts("Hour of day; #{key}, no of regs; #{value}")
		end
	end
end

def save_day_to_file(file_name, data)
	File.open(file_name, 'a') do |file|
		data.each do |key, value|
			file.puts("Day of week; #{key}, no of regs; #{value}")
		end
	end
end

# collect_hour(source_data, times_array)
collect_day(source_data, days_array)
day_frequency(days_array, day_count_hash)
# hour_frequency(times_array, time_count_hash)
# save_hour_to_file(file_name, time_count_hash)
save_day_to_file(file_name, day_count_hash)