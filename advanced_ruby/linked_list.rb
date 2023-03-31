require 'pry-byebug'
# Write full rspec tests for this
class LinkedList
  attr_accessor :head

  def initialize
    @head = nil
  end
 
  def append(value)
    if head.nil?
     self.head = Node.new(value, nil)
    else
      last_node = head
      until last_node.next_node.nil?
        last_node = last_node.next_node
      end
      last_node.next_node = Node.new(value, nil)
    end
  end

  def prepend(value)
    if head.nil?
      self.head = Node.new(value, nil)
    else
      self.head = Node.new(value, self.head)
    end
  end
  
  def contains?(value)
    current_node = head
    until current_node.nil?
      if current_node.value == value
        puts "yay, found #{current_node.value}."
        return true
      end
      current_node = current_node.next_node
    end
    puts "LinkedList does not contain #{value}."
    false
  end

  def remove(value)
    return if head.nil?
    current_node = head
    prev_node = nil

    until current_node.nil?
      if current_node.value == value
        if prev_node.nil?
          self.head = current_node.next_node
          return
        else
          prev_node.next_node = current_node.next_node
          return
        end
      end
      prev_node = current_node
      current_node = current_node.next_node
    end
  end

  def remove_at(index)
  end

  # def size
  # end
  
  # def head_node
  # end
  
  # def tail_node
  # end
  
  # def at(index)
  # end
  
  # def pop
  # end
  
  # def find(value)
  # end
  
  # def to_s
  # end
  
  
end

private

class Node
  attr_accessor :value, :next_node
  
  def initialize(value, next_node)
    @value = value
    @next_node = next_node
  end
end


ll = LinkedList.new

ll.prepend(10)
ll.prepend(20)
ll.prepend(25)
ll.prepend(2)
ll.prepend(13)

ll.contains?(10)
ll.contains?(20)
ll.contains?(25)
ll.contains?(30)

ll.remove(10)
ll.contains?(10)
p ll.inspect


ll.remove(25)
ll.contains?(25)
p ll.inspect


# ll.contains?(10)
# ll.remove(10)
# p ll.inspect
# ll.contains?(10)
# ll.contains?(2)
# p ll.inspect

# puts "ll is #{ll.inspect}"
# puts "ll.head is #{ll.head.inspect}"
# puts "ll.head.value is #{ll.head.value.inspect}"
# puts "ll.head.next_node is #{ll.head.next_node.inspect}"
# puts ll.head.next_node
# puts ll.next_node

# ll.append(5)

# p ll.inspect
# # binding.pry
# p "head's value is #{ll.head.value}"
# p "head's next_node is; #{ll.head.next_node.nil? ? "nil" : "not nil"}";

# ll.append(1)
# p ll.inspect
# p "head's next_node value is #{ll.head.next_node.value}"
# p "head's next_node is; #{ll.head.next_node.nil? ? "nil" : "not nil"}";

# ll.append(6)
# p ll.inspect
# p "head's next_node value is #{ll.head.next_node.next_node.value}"
# p "head's next_node is; #{ll.head.next_node.next_node.nil? ? "nil" : "not nil"}";

# ll.contains?(1)
# ll.contains?(5)
# ll.contains?(15)
# ll.contains?(6)

# ll.prepend(23)
# ll.contains?(23)
# ll.contains?(6)