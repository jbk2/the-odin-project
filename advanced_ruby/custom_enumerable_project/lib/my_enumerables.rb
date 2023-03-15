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

  def my_select
    
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