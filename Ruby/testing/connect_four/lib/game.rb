class ConnectFour
  def initialize
    @board = Array.new(6) { Array.new(7, ' ') }
    @current_player = 'X'
    @game_over = false
  end

  def play
    until @game_over
      display_board
      get_move
      check_for_winner
      switch_players
    end
    display_board
    puts "Game Over! #{@current_player} wins!" unless @game_over == "tie"
    puts "It's a tie!" if @game_over == "tie"
  end

  private

  def display_board
    puts " 1 2 3 4 5 6 7"
    puts "|#{@board[0].join('|')}|"
    puts "|#{@board[1].join('|')}|"
    puts "|#{@board[2].join('|')}|"
    puts "|#{@board[3].join('|')}|"
    puts "|#{@board[4].join('|')}|"
    puts "|#{@board[5].join('|')}|"
    puts "---------------"
  end

  def get_move
    puts "#{@current_player}'s turn. Enter column number (1-7):"
    column = gets.chomp.to_i - 1
    while column < 0 || column > 6 || @board[0][column] != ' '
      puts "Invalid move. Enter column number (1-7):"
      column = gets.chomp.to_i - 1
    end
    row = 5
    while row >= 0
      break if @board[row][column] == ' '
      row -= 1
    end
    @board[row][column] = @current_player
  end

  def check_for_winner
    @board.each_with_index do |row, row_index|
      row.each_with_index do |cell, column_index|
        next if cell == ' '
        if (column_index <= 3 && @board[row_index][column_index + 1] == cell && @board[row_index][column_index + 2] == cell && @board[row_index][column_index + 3] == cell) ||
           (row_index <= 2 && @board[row_index + 1][column_index] == cell && @board[row_index + 2][column_index] == cell && @board[row_index + 3][column_index] == cell) ||
           (row_index <= 2 && column_index <= 3 && @board[row_index + 1][column_index + 1] == cell && @board[row_index + 2][column_index + 2] == cell && @board[row_index + 3][column_index + 3] == cell) ||
           (row_index <= 2 && column_index >= 3 && @board[row_index + 1][column_index - 1] == cell && @board[row_index + 2][column_index - 2] == cell && @board[row_index + 3][column_index - 3] == cell)
          @game_over = true
          return
        end
      end
    end
    if @board.flatten.none? { |cell| cell == ' ' }
      @game_over = "tie"
    end
  end

  def switch_players
    @current_player = @current_player == 'X' ? 'O' : 'X'
  end
end

game = ConnectFour.new
game.play
