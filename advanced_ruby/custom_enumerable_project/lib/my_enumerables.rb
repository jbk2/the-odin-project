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

  # def my_select(&block)
  #   selected = []
  #   if block_given?
  #     for element in self
  #       if block.call(element) # == true
  #         selected << element
  #       end
  #     end
  #     selected
  #   else 
  #     self.to_enum
  #   end
  # end

  def my_select(&block)
    selected = []
    if block_given?
      self.my_each do |element|
        if block.call(element) == true
          selected << element
        end
      end
      selected
    else 
      self.to_enum
    end
  end

end

class Array
  # def my_each
  #   if block_given?
  #     for element in self
  #       yield(element)
  #     end
  #   else
  #     self.to_enum
  #   end
  # end

  #perhaps this #my_each reads easier than the above because it illlustrates the passed block as an argument.
  def my_each(&block) 
    if block_given?
      for element in self
        block.call(element)
      end
    else
      self.to_enum
    end
  end
end