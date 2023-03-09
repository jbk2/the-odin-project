require 'pry-byebug'
# Caesar Cypher Project

# caesar_cipher("What a string!", 5)

# should return=> "Bmfy f xywnsl!"


def alpha_index_hash
  ai_hash = Hash.new
  ('a'..'z').to_a.each_with_index do |item, index|
    a = Hash.new { |hash, key| hash[item] = index }
    ai_hash[item] = index + 1
  end
   ai_hash
end

def negative_corrected(number)
  if number <= 0
    26 + number
  else
    number
  end
end

def cipher(string, factor)
  string_array = string.downcase.split('')
  ai_hash = alpha_index_hash
  ciphered_array_alpha = []

  string_array.each do |item|
    if item == ' '
      ciphered_array_alpha << ' '
    else
      ciphered_array_number = negative_corrected(ai_hash[item] - factor)
      ciphered_array_alpha << ai_hash.key(ciphered_array_number)
    end
  end
  puts ciphered_array_alpha.join
end

# cipher('abcdz', 9)

ord_array = [] 

('A'..'Z').to_a.each do |item|
  ord_array << item.ord
end

puts ord_array


# def yell_greeting(string)
#   name = string


#   name = name.upcase
#   greeting = "WASSAP, #{name}!"
#   puts greeting
# end

# yell_greeting("bob")

# --------------------------- -----------------------------

# def isogram?(string)
#   original_length = string.length
#   string_array = string.downcase.split

#   binding.pry

#   unique_length = string_array.uniq.length
#   original_length == unique_length
# end

# isogram?("Odin")

# --------------------------- -----------------------------

# string1 = "fewchars"
# string2 = "above10chars"

# def cap_if_above_10(string)
# 	string.length > 10 ? puts(string.upcase) : puts(string)
# 	# puts string
# end

# # cap_if_above_10(string1)

# # cap_if_above_10(string2)


# def number_range(input)
# 	answer = input.to_i
# end

# case number_range(gets.chomp)
# when 0..50 		then puts("your input was between 0 and 50")
# when 51..100 	then puts("your input was between 51 and 100")
# else 					puts("your input was above 100")
# end