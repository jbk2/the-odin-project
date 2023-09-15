require_relative '../lib/knight.rb'

describe Knight do
  let(:knight) { Knight.new(3,3) }
  describe "a knight object's x and y variables" do
    it 'are given to it on instantiaton and are readable' do
      knights_x_coor = knight.x
      knights_y_coor = knight.y
      expect(knights_x_coor).to equal(3)
      expect(knights_y_coor).to equal(3)
    end
  end

  describe "#all_knights_moves" do
    context 'with a knight in coords 3,3' do
      it 'has 8 L shaped move possibilities' do
        result = knight.all_knights_moves(3,3)
        moves_array = [[5, 4],[5, 2],[1, 4],[1, 2],[4, 5],[2, 5],[4, 1],[2, 1]]
        expect(result).to eq(moves_array)
      end
    end
    
    context 'with a knight in coords 2,5' do
      it 'has 8 L shaped move possibilities' do
        knight = Knight.new(2,5)
        result = knight.all_knights_moves(2,5)
        moves_array = [[4, 6],[4, 4],[0, 6],[0, 4],[3, 7],[1, 7],[3, 3],[1, 3]]
        expect(result).to eq(moves_array)
      end
    end
    
    context 'with a knight in 0,0 coords' do
      it "still gives 8 L shaped moves despite some being out of bounds, i.e. knight does not know about a board's bounds" do
        knight = Knight.new(0,0)
        result = knight.all_knights_moves(0,0)
        moves_array = [[2, 1],[2, -1],[-2, 1],[-2, -1],[1, 2],[-1, 2],[1, -2],[-1, -2]]
        expect(result).to eq(moves_array)    
      end
    end
  end


end
