class Board
  attr_reader :x_size, :y_size, :knight
  attr_accessor :squares_array

  def initialize(dimension)
    @x_size = dimension - 1 # -1 to bring to 0 index
    @y_size = dimension - 1 # -1 to bring to 0 index
    @squares_array = create_grid(dimension)
  end

  def add_knight(knight)
    if piece_within_bounds?(knight)
      @knight = knight
      squares_array[knight.x][knight.y] = @knight
    else
      puts "knight is out of board's bounds"
    end
  end

  def piece_within_bounds?(knight)
    knight.x.between?(0, x_size) && knight.y.between?(0, y_size) ? true : false
  end

  def create_grid(dimension)
    grid = []
    dimension.times { grid << Array.new(8, nil) }
    grid
  end

  def grid_position(x,y)
    squares_array[x][y]
  end

end
