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


  describe '#add_knight' do
    context "if knight's coords are within board's bounds" do
      it "can have a knight" do
        board.add_knight(knight)
        expect(board.knight).to be(knight) 
      end
    end
    
    context "if knight's coords are outside of board's bounds" do
      it "will not accept the knight" do
        board.add_knight(oob_knight)
        expect(board.knight).to be(nil)
        expect { board.add_knight(oob_knight) }.to output("knight is out of board's bounds\n").to_stdout
      end
    end
  end
  

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


  describe '#piece_within_bounds?' do
    context "if knight's coords are within boards bounds" do
      it "returns true" do
        result = board.piece_within_bounds?(knight)
        expect(result).to be(true)
      end  
    end

    context "if knight's coords are outside of boards bounds" do
      it "returns false" do
        oob_knight = Knight.new(11,15)
        result = board.piece_within_bounds?(oob_knight)
        expect(result).to be(false)
      end  
    end
  end

end