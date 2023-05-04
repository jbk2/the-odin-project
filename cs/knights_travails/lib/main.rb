require_relative 'board'
require_relative 'knight'

board = Board.new(8)
first_knight = Knight.new(0,0)
board.add_knight(first_knight)
# puts "heres grid 00; #{board.grid_position(0,0)}"
# puts ''
# p board
# p board.valid_knights_moves(first_knight.x, first_knight.y)

# p board.knight_moves([3,3],[5,4])
# p board.public_methods(false).count
p first_knight.public_methods(false)


# match?([[[1, 1], [8, 8]]], "\[\d,\d\]")



