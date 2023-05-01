require_relative 'board'
require_relative 'knight'

board = Board.new(8)
first_knight = Knight.new(0,0)
board.add_knight(first_knight)
puts "heres grid 00; #{board.grid_position(0,0)}"
puts ''
p board




