require 'pry-byebug'

def merge_sort(array)
  return array if array.length < 2 # base case
  middle = array.length/2.floor
  left, right = merge_sort(array.take(middle)), merge_sort(array.drop(middle))
  puts "l = #{left} ****"
  puts "r = #{right} ****"
  sorted_array = []
  sorted_array << (left[0] < right[0] ? left.shift : right.shift) until left.empty? || right.empty?
  sorted_array + left + right
end

b = Array.new(8) {rand(1..9)}
puts merge_sort(b)