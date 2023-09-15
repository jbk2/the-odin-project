require 'open-uri'

url = "http://ruby.bastardsbook.com/files/fundamentals/hamlet.txt"
local_file_name = "hamlet.txt"

# web_data = URI.open(url).read
# my_local_file = URI.open(local_file_name, 'w')
# my_local_file.write(web_data)

hamlet = File.open("hamlet.txt") do |content|
	puts content.readlines[43]
end

puts Dir.glob('~/Downloads/*').length

# puts web_data

# URI.open(url, 'r') do |f|
# 	puts f.readlines[43]
# end

