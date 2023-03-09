require 'pry-byebug'

dictionary = ["below","down","go","going","horn","how","howdy","it", "it", "i","low","own","part","partner","sit"]
word = "it how"


def substrings(string, dictionary)

	string_array = string.downcase.split
	hash_result = Hash.new(0)

	string_array.each do |string|
		dictionary.each do |i|
			if i.include?(string)
				then hash_result[string] +=1
			end 
		end
	end
	p hash_result
end


substrings(word, dictionary)







	# look for word in any of the substring array elements,
	# if present count number of times present,
	# return word and frequency
	# result = Hash.new

	# words.each do |i|
	# 	matches = i.scan(word).length
	# 	result[i] = matches unless matches == 0
	# end

	# p result
		


	# tally = words.tally

	# tally.each do |key,value|
	# 	if key == word
	# 		matches_hash = Hash.new
	# 		matches_hash[key] = value
	# 		puts matches_hash
	# 	end
	# end



# def substrings(string, dictionary) 
#   string = string.downcase
#   count = string.split(' ').reduce(Hash.new(0)) do |object, word|
#     dictionary.each {|element| object[element] += 1 if word.include?(element)}
#     object
#   end
#   return count
# end
