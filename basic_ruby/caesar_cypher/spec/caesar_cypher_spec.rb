require './lib/caesar_cypher.rb'

describe "caesar_cypher" do
  describe "#cypher" do
    it "should return a chracters adjusted by given index" do
      expect(cypher("abcd", 1)).to eql('bcde')
    end
  end

end