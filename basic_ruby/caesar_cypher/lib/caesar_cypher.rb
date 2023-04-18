require 'pry-byebug'
# Caesar Cypher Project
# caesar_cypher("What a string!", 5)
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

def cypher(string, factor)
  string_array = string.downcase.split('')
  ai_hash = alpha_index_hash
  cyphered_array_alpha = []

  string_array.each do |item|
    if item == ' ' || item.match(/[^a-zA-Z]/)
      cyphered_array_alpha << item
    else
      cyphered_array_number = negative_corrected(ai_hash[item] - factor)
      cyphered_array_alpha << ai_hash.key(cyphered_array_number)
    end
  end
  puts cyphered_array_alpha.join
end

ord_array = [] 

('A'..'Z').to_a.each do |item|
  ord_array << item.ord
end
