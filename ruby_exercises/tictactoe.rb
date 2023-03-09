require 'pry-byebug'

class Board
	attr_accessor :position

	def initialize
		@position = {11 => '_', 21 => '_', 31 => '_', 12 => '_', 22 => '_', 32 => '_', 13 => '_', 23 => '_', 33 => '_'}
	end

	def display_board
		puts "#{@position[11]} #{@position[21]} #{@position[31]}"
		puts "#{@position[12]} #{@position[22]} #{@position[32]}"
		puts "#{@position[13]} #{@position[23]} #{@position[33]}"
	end
end


class User
	attr_reader :name, :piece

	def initialize(name, piece)
		@name = name
		@piece = piece
	end
end


class Game
	attr_accessor :turn_count, :selected_user, :board

	def initialize
		@user1 = User.new('user1', 'X')
		@user2 = User.new('user2', '0')
		@board = Board.new
		@selected_user = @user1
		@turn_count = 0
	end

	def random_user
		@selected_user = [@user1, @user2].sample
	end

	def change_user
		if @selected_user == @user1
			then @selected_user = @user2
		else @selected_user = @user1
		end
	end

	def users_turn
		if turn_count == 0
		then random_user
			puts "You're first '#{selected_user.name}', please input your x coord, followed by your y coord with comma between"
		elsif turn_count <= 9
			puts "Your turn now '#{selected_user.name}', please input your x coord, followed by your y coord with comma between"
		else
			puts "no winner"
		end
		users_entry = gets.chomp
		xy_coord = users_entry.split(',')[0] + users_entry.split(',')[1]
		update_board(selected_user, xy_coord)
		check_for_winner
		board.display_board
		@turn_count += 1
		change_user
		users_turn
	end

	def update_board(selected_user, xy_coord)
		if board.position[xy_coord.to_i] == "_"
			board.position[xy_coord.to_i] = selected_user.piece #update the board
			# binding.pry 
		else puts 'this coord has already been taken, choose another'
			users_turn
		end
	end
		
	def check_for_winner
		winning_combos = [[11,12,13], [21,22,23], [31,32,33], [11,21,31], [12,22,32], [13,23,33], [11,22,33], [31,22,13]]
		winning_combos.each do |positions|
				# binding.pry
			scores = board.position[positions[0]] + board.position[positions[1]] + board.position[positions[2]] 
			if scores.eql?("XXX") || scores.eql?("000")
				puts "yay, #{@selected_user} is the winner"
					finish_game
			end
		end
	end

	def finish_game
		puts 'Game over'
		exit
	end
end


b = Board.new
b.display_board

g = Game.new
g.users_turn