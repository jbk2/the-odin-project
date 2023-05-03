require_relative '../lib/board.rb'
require_relative '../lib/knight.rb'

describe Board do
  let(:board) { Board.new(8) }
  let(:knight) { Knight.new(3,3) } # 0 indexed
  let(:oob_knight) { Knight.new(11,15) }
  
  describe "a board" do
    it 'has, readable, dimensions' do
      expect(board.x_size).to equal(8 - 1)
      expect(board.y_size).to equal(8 - 1)
    end
  end

# ------------------------------------------------------------------------
  describe '#add_knight' do
    context "within board's bounds" do
      it "will accept a knight" do
        board.add_knight(knight)
        expect(board.knight).to be(knight) 
      end
    end
    
    context "outside of board's bounds" do
      it "will not accept a knight" do
        board.add_knight(oob_knight)
        expect(board.knight).to be(nil)
        expect { board.add_knight(oob_knight) }.
         to output("knight's x:11 & y:15 coords are out of board's 8x8 bounds.\n").to_stdout
      end
    end
  end
  
# ------------------------------------------------------------------------
  describe '#grid_position()' do
    before { board.add_knight(knight) }
    
    context 'when occupied' do
      it "returns it's occupant" do
        result = board.grid_position(3,3)
        expect(result).to be(knight)
      end
    end
    
    context 'when unoccupied' do
      it 'returns nil' do
        result = board.grid_position(7,7)
        expect(result).to be_nil
      end
    end
  end

  # ------------------------------------------------------------------------
  describe '#coords_within_bounds?' do
    context "if coords are within boards bounds" do
      it "returns true" do
        result = board.coords_within_bounds?(knight.x, knight.y)
        expect(result).to be(true)
      end  
    end

    context "if coords are outside of boards bounds" do
      it "returns false" do
        oob_knight = Knight.new(11,15)
        result = board.coords_within_bounds?(oob_knight.x, oob_knight.y)
        expect(result).to be(false)
      end  
    end
  end

# ------------------------------------------------------------------------
  describe '#valid_knights_moves' do
    context "when all knight's moves are within bounds" do
      it 'returns a 2D array with 8 coordinates' do
        board.add_knight(knight)
        result = board.valid_knights_moves(knight.x, knight.y)
        valid_moves_array = [[5, 4],[5, 2],[1, 4],[1, 2],[4, 5],[2, 5],[4, 1],[2, 1]]
        expect(result).to eq(valid_moves_array)
      end
    end
    
    context "when some of knight's moves are out of bounds, negatively" do
      it 'returns a 2D array with 2 valid coordinates' do
        knight = Knight.new(0,0)
        board.add_knight(knight)
        result = board.valid_knights_moves(knight.x, knight.y)
        valid_moves_array = [[2, 1],[1, 2]]
        expect(result).to eq(valid_moves_array)
      end
    end
    
    context "when some of knight's moves are out of bounds, positively" do
      it 'returns a 2D array with 2 valid coordinates' do
        knight = Knight.new(7,7)
        board.add_knight(knight)
        result = board.valid_knights_moves(knight.x, knight.y)
        valid_moves_array = [[5, 6],[6, 5]]
        expect(result).to eq(valid_moves_array)
      end
    end
    
    context "when some of knight's moves are out of bounds, positively" do
      it 'returns a 2D array with 4 valid coordinates' do
        knight = Knight.new(6,6)
        board.add_knight(knight)
        result = board.valid_knights_moves(knight.x, knight.y)
        valid_moves_array = [[4, 7], [4, 5], [7, 4], [5, 4]]
        expect(result).to eq(valid_moves_array)
      end
    end
  end

# ------------------------------------------------------------------------
  describe '#knight_moves()' do
    context 'when end move is 1 move away' do
      it 'returns the start coords and end coords' do
        board.add_knight(knight)
        result = board.knight_moves([3,3], [5,4])
        expect(result).to eq([[3,3], [5,4]]) 
      end
    end
    
    context 'when end move is 2 moves away' do
      it 'returns the start coords, the 1st move coords & end coords' do
        board.add_knight(knight)
        result = board.knight_moves([3,3], [7,5])
        expect(result).to eq([[3,3], [5,4], [7,5]]) 
      end
    end
    
    context 'when end move is 3 moves away' do
      it 'returns the start coords, the 2 intermediate move coords & the end coords' do
        board.add_knight(knight)
        result = board.knight_moves([3,3], [6,7])
        expect(result).to eq([[3,3], [5,4], [7,5], [6,7]]) 
      end
    end
    
    context 'when end move is 4 moves away' do
      it 'returns the start coords, the 3 intermediate move coords & the end coords' do
        board.add_knight(knight)
        result = board.knight_moves([3,3], [5,5])
        expect(result).to eq([[3,3], [5,4], [7,5], [6,7], [5,5]]) 
      end
      
      it 'returns the start coords, the intermediate move coords & the end coords' do
        board.add_knight(knight)
        result = board.knight_moves([1,1], [7,7])
        expect(result).to eq([[1, 1], [3, 2], [5, 3], [6, 5], [7, 7]]) 
      end
    end

  end

# ------------------------------------------------------------------------
  describe '#position_found?()' do
    context 'when move is present' do
      it 'returns the array containing the value' do
        moves = [[[2, 1], [[3, 3], nil]], [[4, 1], [[3, 3], nil]], [[2, 5], [[3, 3], nil]],
          [[4, 5], [[3, 3], nil]], [[1, 2], [[3, 3], nil]], [[1, 4], [[3, 3], nil]],
          [[5, 2], [[3, 3], nil]], [[5, 4], [[3, 3], nil]]]
        # board.add_knight(knight)
        result = board.position_found?(moves, [5,4])
        expect(result).to eq([[5, 4], [[3, 3], nil]])
      end
    end
    
    context 'when move is not present' do
      it 'returns false' do
        moves = [[[2, 1], [[3, 3], nil]], [[4, 1], [[3, 3], nil]], [[2, 5], [[3, 3], nil]],
          [[4, 5], [[3, 3], nil]], [[1, 2], [[3, 3], nil]], [[1, 4], [[3, 3], nil]],
          [[5, 2], [[3, 3], nil]]]
        # board.add_knight(knight)
        result = board.position_found?(moves, [5,4])
        expect(result).to be (false)
      end
    end
  end

  describe '#pull_first_value()' do
    context 'with a 6d array' do
      it 'returns a 2d array of true values' do
        six_d_array = [[5, 5], [[6, 7], [[7, 5], [[5, 4], [[3, 3], nil]]]]]
        result = board.pull_first_value(six_d_array)
        expect(result).to eq([[5, 5], [6, 7], [7, 5], [5, 4], [3, 3]])
      end
    end
  end
end