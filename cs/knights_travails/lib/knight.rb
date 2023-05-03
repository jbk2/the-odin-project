class Knight
  attr_reader :x, :y

  def initialize(x, y) # must be given 0 indexed values
    @x = x
    @y = y
  end

  def all_knights_moves(x,y)
    moves = []
    moves.push([x+2, y+1],[x+2, y-1],[x-2, y+1],[x-2, y-1],[x+1, y+2],[x-1, y+2],[x+1, y-2],[x-1, y-2])
    return moves    
  end
end