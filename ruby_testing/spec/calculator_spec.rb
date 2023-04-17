require './lib/calculator.rb'

describe Calculator do
  describe "add" do
    it "returns the sum of two numbers" do
      calculator = Calculator.new
      expect(calculator.add(2,3)).to eql(5)
    end

    it "returns the sum of more than two numbers" do
      calculator = Calculator.new
      expect(calculator.add(1,2,3,4)).to eql(10)
    end
  end

  describe "multiply" do
    it "multiplies two numbers together" do
      
    end
    
    it "multiplies multiple numbers together" do
    end

  end

  describe "subtract" do
    it "subtracts two numbers from each other" do
    end
    
    it "subtracts multiple numbers from each other" do
    end
    
  end

  describe "divide" do
    it "divides one numbers by another" do
    end
    
  end
end