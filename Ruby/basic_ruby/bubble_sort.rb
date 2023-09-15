require 'pry-byebug'

array = [4,3,78,2,0,2]

def bubble_sort(array)
	(array.length - 1).times do
		array.each_with_index	do |item, index|
			if array[index + 1] && item > array[index + 1]
				then array[index], array[index + 1] =  array[index + 1], array[index]
			else p "either end of row or left is smaller than right"
			end
			p array
		end
	end
end

p bubble_sort(array)

