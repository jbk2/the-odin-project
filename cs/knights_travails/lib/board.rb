class Board
  attr_reader :x_size, :y_size, :knight
  attr_accessor :grid_array

  def initialize(dimension)
    @x_size = dimension - 1 # -1 to bring to 0 index
    @y_size = dimension - 1 # -1 to bring to 0 index
    @grid_array = create_grid(dimension)
  end

  def add_knight(knight) # only allows x1 knight currently
    if coords_within_bounds?(knight.x, knight.y)
      @knight = knight
      grid_array[knight.x][knight.y] = @knight
    else
      puts "knight's x:#{knight.x} & y:#{knight.y} coords are out of board's #{x_size + 1}x#{y_size + 1} bounds."
    end
  end
  
  def coords_within_bounds?(x, y)
    x.between?(0, x_size) && y.between?(0, y_size) ? true : false
  end

  def valid_knights_moves(x,y)
    all_moves = knight.all_knights_moves(x,y)
    valid_moves = []
    all_moves.each do |coord|
      x = coord[0]
      y = coord[1]
      if coords_within_bounds?(x, y)
        valid_moves << coord
      end
    end
    valid_moves
  end

  def knight_moves(start_coords, end_coords)
    valid_coords_queue = [[start_coords, nil]]
    check(valid_coords_queue, end_coords)
  end

  def check(valid_coords_queue, end_coords) 
    if found_coordinate = position_found?(valid_coords_queue, end_coords)
      moves = moves_path(found_coordinate)
      moves_count = moves.count - 1
      puts "you made it in #{moves_count} moves, here's your path:"
      puts "#{moves}"
      return moves
    else
      parent = valid_coords_queue.pop
      valid_moves = valid_knights_moves(parent[0][0], parent[0][1])
      # puts "here's valid moves from #{parent[0]} -- #{valid_moves}"
      valid_moves.each do |coord|
        valid_coords_queue.prepend([coord, parent])
      end
    end
    check(valid_coords_queue, end_coords)
  end

  def check_coords_presence(valid_coords, desired_coord)
    valid.coords.include?(desired_coord)
  end

  def create_grid(dimension)
    grid = []
    dimension.times { grid << Array.new(8, nil) }
    grid
  end
  
  def grid_position(x,y)
    grid_array[x][y]
  end
  
  def position_found?(valid_coords_queue, end_coord)
    valid_coords_queue.each do |e|
      case e
      in [^end_coord, *]
        return e
      else
        next
      end
    end
    return false
  end

  def moves_path(nested_array)
    pull_first_value(nested_array).reverse
  end

  def pull_first_value(array, output = [])
    return output if array[0].nil? || array.empty?
    array.length >= 2 ? output << array.shift : array.flatten!(1)
    pull_first_value(array, output)
  end
end