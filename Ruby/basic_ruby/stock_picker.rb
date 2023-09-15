require 'pry-byebug'

prices = [17,3,6,9,15,8,6,1,10]

def stock_picker(array)

	# days_price = Hash.new(0)
	# array.each_with_index do |element, index|
	# 	days_price[index + 1] = element
	# end

	comb_array = array.combination(2).to_a
	difference_array = Array.new

	comb_array.each do |i|
		if i[0] < i[1]
			then difference_array << [array.index(i[0]), array.index(i[1]), (i[1] - i[0])]
		end
	end

	max_and_index = difference_array.flatten.each_with_index.max

	p "flattened diff array #{difference_array.flatten}"
	p "*************************************************************"
	p "here's the positive differences #{difference_array}"
	p "*************************************************************"
	p "here's the max with index  #{max_and_index}"
	p "*************************************************************"
	p "*************************************************************"
	p "best to buy on day #{difference_array.flatten[max_and_index[1] - 2] + 1}"
	p "best to sell on day #{difference_array.flatten[max_and_index[1] - 1] + 1}"
	p "*************************************************************"
end

	# must choose the two numbers with the largest gap between each other

	# put difference in Array
	# then select max value 
	# max


	# comb_array.each_with_index do |iterator, index|
	# 	difference_hash[index] = iterator[0] - iterator[1]
	# end

	# p difference_hash
	
	# days_price = Hash.new(0)
	# array.each_with_index do |element, index|
	# 	days_price[index + 1] = element
	# end

	# # days_price.each do |k,v|


	# end


stock_picker(prices)