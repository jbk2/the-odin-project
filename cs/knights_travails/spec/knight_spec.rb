require_relative '../lib/knight.rb'

describe Knight do
  describe "a knight object's x and y variables" do
    it 'are given to it on instantiaton and are readable' do
      knight = Knight.new(0,1)
      knights_x_coor = knight.x
      knights_y_coor = knight.y
      expect(knights_x_coor).to equal(0)
      expect(knights_y_coor).to equal(1)
    end
  end

  describe "a knight's board position" do
    
  end
end
