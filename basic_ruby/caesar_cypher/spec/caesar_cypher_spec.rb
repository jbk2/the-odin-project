require './lib/caesar_cypher.rb'

describe "caesar_cypher" do
  describe "#cypher" do
    it "should return chracters adjusted by given index" do
      expect {cypher("abcd", 1)}.to output("zabc\n").to_stdout
      expect {cypher("ghijk", 6)}.to output("abcde\n").to_stdout
    end

    it "should cypher alpha chars only" do
      expect {cypher("abcd!", 1)}.to output("zabc!\n").to_stdout
    end

    it "should still retain non-alpha chars" do
      expect {cypher("a1b?cd!", 1)}.to output("z1a?bc!\n").to_stdout
      expect {cypher("25*(1?!", 1)}.to output("25*(1?!\n").to_stdout
    end


  end

end