module Enumerable
  
  def my_each_with_index
    count = 0
    if block_given?
      for element in self
        yield(element, count)
        count += 1
      end
    else
      self.to_enum
    end
  end

end

class Array
  def my_each
    if block_given?
      for element in self
        yield(element)
      end
    else
      self.to_enum
    end
  end
end


 a = %w'1 4 6 2 6 8 8 4'

 puts a.to_enum.inspect

