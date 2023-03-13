require 'pry-byebug'

# Handy methods from IO / File IO / Line IO / Character IO classes that I found helpful; , 
	# IO
		# 
	# File IO
		# #new, #open, #read, #write, #close, #path, #readlink, #birthtime, #directory?, #readable?, #writable?, #empty?, #size, #chmod, #chown, #rename, #truncate
	# Line IO
		# #gets || #readline, #readlines, #eachline || #each, #eof?, #tell || #pos, #lineno, #foreach, #seek, #rewind
	# Character IO
		# 

class Game
	attr_accessor :chosen_word, :no_of_guesses_allowed, :no_of_guesses_taken, :result, :guesses, :loaded_game

	def initialize
		@chosen_word						= String.new
		@no_of_guesses_allowed	= 0
		@no_of_guesses_taken		=	0
		@result 								= Hash.new
		@guesses								= Array.new
		@loaded_game						= false
	end

	public #*************************************

	def play_game
		load_game_question
		unless @loaded_game == true
			random_word_with_length(5,9)
			initialize_result_hash
			initialize_guess_allowance
		end
		until game_over?
			human_players_turn
			display_result
		end
	end

	private #*************************************

	def initialize_result_hash
		@chosen_word.split('').each_with_index do |char, index|
			@result[index] = [char, '_']
		end
		# puts "initial result is; #{@result}"
	end

	def initialize_guess_allowance
		@no_of_guesses_allowed = @chosen_word.length
		puts "you are allowed #{@no_of_guesses_allowed} guesses."
	end

	def load_game_question
		puts 'would you like to load prevoius game? type y or n'
		load = gets.chomp
		if load == 'y'
			@loaded_game = true
			load_game
		end
	end

	def load_game
		old_game = Marshal.load(File.read('dump'))
		@chosen_word						= old_game.chosen_word
		@no_of_guesses_allowed	= old_game.no_of_guesses_allowed
		@no_of_guesses_taken		=	old_game.no_of_guesses_taken
		@result 								= old_game.result
		@guesses								= old_game.guesses
		puts "game loaded, here's current status; #{pretty_print_result}\nand you have #{@no_of_guesses_allowed} guesses remaining."
	end

	def random_word_with_length(shortest, longest)
		dictionary = 'google-10000-english-no-swears.txt'
		dictionary_file = File.open(dictionary, 'r')
		array_of_words = dictionary_file.to_a
		loop do
			random_word = array_of_words.sample 
			if random_word.strip.length.between?(shortest, longest)
				@chosen_word = random_word.strip
				puts "random word between #{shortest} and #{longest} chars has been chosen"
				return @chosen_word
			end
		end
		dictionary_file.close
	end

	def human_players_turn
		if @no_of_guesses_taken > 0
			puts 'would you like to save your game? type y or n'
			save = gets.chomp
			if save == 'y'
				save_game
			end
		end
		
		puts "please guess a letter or word"
		guess = gets.chomp
		@no_of_guesses_taken += 1
		check_guess(guess)
	end

	def check_guess(guess)
		guess.split('').each_with_index do |item, index|
			@result.each_pair do |k, v|
				if v[0] == item 
					v[1] = item
				end
			end
		end
	end
	
	def pretty_print_result
		result_string = ""
		@result.each_pair do |k,v|
			result_string << v[1]
		end
		result_string
	end

	def display_result
		puts "you've had #{@no_of_guesses_taken} out of #{@no_of_guesses_allowed} allowed guesses"
		puts "heres the current result #{pretty_print_result}"
		# binding.pry
	end

	def game_over?
		if !pretty_print_result.include?('_')
				puts "well done, you won #{pretty_print_result} ********"
				return true
		elsif @no_of_guesses_taken >= @no_of_guesses_allowed
			puts "sorry, you've used all your guesses, you lose, game over "
			return true
			# exit
		end
	end

	def save_game
		instance = Marshal.dump(self)
		serialized_file = File.write('dump', instance)
		puts 'file saved, bye'
		exit
	end
end

g = Game.new
g.play_game