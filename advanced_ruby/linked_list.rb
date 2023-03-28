require 'pry-byebug'

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

  # def prepend(value)
  #   if head.nil?
  #     self.head = Node.new(value, nil)
  #   else
  #     head = Node.new(value, self.head)
  #   end
  # end
  
  # def size
  # end
  
  # # def head
  # # end
  
  # def tail
  # end
  
  # def at(index)
  # end
  
  # def pop
  # end
  
  # def find(value)
  # end
  
  # def to_s
  # end
  
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
ll.append(5)

p ll.inspect
# binding.pry
p "head's value is #{ll.head.value}"
p "head's next_node is; #{ll.head.next_node.nil? ? "nil" : "not nil"}";

ll.append(1)
p ll.inspect
p "head's next_node value is #{ll.head.next_node.value}"
p "head's next_node is; #{ll.head.next_node.nil? ? "nil" : "not nil"}";

ll.append(6)
p ll.inspect
p "head's next_node value is #{ll.head.next_node.next_node.value}"
p "head's next_node is; #{ll.head.next_node.next_node.nil? ? "nil" : "not nil"}";

ll.contains?(1)
ll.contains?(5)
ll.contains?(15)
ll.contains?(6)

# ll.prepend(23)
ll.contains?(23)