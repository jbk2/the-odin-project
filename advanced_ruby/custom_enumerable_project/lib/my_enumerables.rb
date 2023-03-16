module Enumerable
  # require 'pry-byebug'
  
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
      my_each do |element|
        if block.call(element) == true
          selected << element
        end
      end
      selected
    else 
      self.to_enum
    end
  end

  def my_all?(&block)
    my_each do |e|
      next if block.call(e) == true
      return false
    end
    return true
  end

  def my_all?
    if block_given?
      my_each do |e|
        next if yield(e) == true
        return false
      end
      true
    else
      unless self == nil
        return true
      end
    end
  end

  def my_any?
    counter = 0
    my_each do |e|
      if yield(e)
        counter += 1
      end
    end
    counter > 0 ? true : false
  end

  def my_none?
    my_each do |e|
      yield(e) ? (return false) : next
    end
    true
  end

  def my_count
    if block_given?
      counter = 0
      my_each { |e| yield(e) ? counter += 1 : next }
      return counter
    else
      return to_a.count
    end
  end

  def my_map
    mapped_array = []
    if block_given?
      my_each do |e|
        mapped_array << yield(e)
      end
      return mapped_array
    else
      self.to_enum
    end
  end

  def my_inject(initial, *method)
    sum = initial
    my_each do |e|
      new_value = (yield(sum, e.to_i))
      sum = new_value
    end
    return sum
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

# a = %w'1 53 77 2 7 8'
# e = a.to_enum
# puts a.my_inject(0) { |sum, value| sum + value }