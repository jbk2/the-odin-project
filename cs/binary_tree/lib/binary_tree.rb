require 'pry-byebug'

class Node
attr_accessor :value, :left, :right
  def initialize(value)
    @value = value
    @left = nil
    @right = nil
  end
end

def depth_first_values_manual(root)
  return [] if root == nil
  result = []
  stack = [root]
  while stack.count > 0
    current = stack.pop
    # puts current.value
    result.push(current.value)
    stack.push(current.right) if current.right
    stack.push(current.left) if current.left
  end
  result
end

def depth_first_values_recursive(root)
  return [] if root == nil
  left_values = depth_first_values_recursive(root.left)
  right_values = depth_first_values_recursive(root.right)
  return [root.value, left_values, right_values].flatten
end
# Not possible to have a recursive breadth first traversal because fundamentally
# recursion relies on the call stack, and breadth first needs a queue not a stack.
def breadth_first_values(root)
  return [] if root == nil
  values = []
  queue = [root]
  while queue.count > 0
    current = queue.pop
    values.push(current.value)
    queue.prepend(current.left) if current.left
    queue.prepend(current.right) if current.right
  end
  return values
end

def tree_includes?(root, value)
  # non_matchers = []
  queue = [root]
  count = 0

  while queue.count > 0
    current = queue.pop
    count += 1
    if current.value == value
      return true
      # puts "yay #{value} was present in this node's; #{current.inspect}." 
      # p non_matchers
      # puts "it took #{count} loops to find #{value}, and here are the non matches:"
      # return non_matchers
    else  
      # non_matchers << current.value
      queue.prepend(current.left) if current.left
      queue.prepend(current.right) if current.right
    end  
  end
  return false
end

def tree_includes_v1?(root, value)
  non_matchers = []
  queue = [root]
  count = 0

  while queue.count > 0
    current = queue.pop
    count += 1
    if current.value == value
      puts "yay #{value} was present in this node's @value; #{current.inspect}." 
      puts "it took #{count} loops to find #{value}, and here are the non matches:"
      return non_matchers
    else  
      non_matchers << current.value
      queue.prepend(current.left) if current.left
      queue.prepend(current.right) if current.right
    end  
  end
  return false
end

def tree_includes_v2?(root, value)
  return false if root.nil? 
  queue = [root]
  while queue.count > 0
    current = queue.pop
    return true if current.value == value
    queue.prepend(current.left) if current.left
    queue.prepend(current.right) if current.right
  end
  return false
end



def tree_includes_resursive?(root, value)
  return false if root.nil?
  return true if root.value == value
  tree_includes_resursive?(root.left, value)
  tree_includes_resursive?(root.right, value)
end

def tree_sum_iterative(root)
  return 0 if root == nil
  queue = [root]
  sum = 0
  while queue.count > 0
    current = queue.pop
    sum += current.value
    queue.prepend(current.left) if current.left
    queue.prepend(current.right) if current.right
  end
  return sum
end

def tree_sum_recursive(root)
  return 0 if root == nil
  root.value + tree_sum_recursive(root.left) + tree_sum_recursive(root.right)
end

def tree_min_value(root)
  return nil if root == nil
  lowest_value = Float::INFINITY
  stack = [root]

  while stack.count > 0
    current = stack.pop
    lowest_value = current.value if current.value < lowest_value
    stack.push(current.right) if current.right
    stack.push(current.left) if current.left
  end
  return lowest_value
end

def tree_min_value_recursive(root)
  return Float::INFINITY if root == nil
  left_min = tree_min_value_recursuve(root.left) if root.left
  right_min = tree_min_value_recursuve(root.right) if root.right
   return [root.value, left_min, right_min].compact.min
end

def max_root_to_leaf(root)
  return -1.0/0.0 if root == nil
  return root.value if root.left == nil && root.right == nil #definition of a leaf
  max_child_path_sum = [max_root_to_leaf(root.left), max_root_to_leaf(root.right)].max
  return root.value + max_child_path_sum
end

# ****************************************************************

# a = Node.new('a')
# b = Node.new('b')
# c = Node.new('c')
# d = Node.new('d')
# e = Node.new('e')
# f = Node.new('f')

# a.left = b
# a.right = c
# b.left = d
# b.right = e
# c.right = f

#         a
#        /  \
#       b    c
#      / \    \
#     d   e     f

# p depth_first_values_manual(a)
# p depth_first_values_recursive(a)
# p breadth_first_values(a)
# p tree_includes_v2?(nil, "x")
# p tree_includes_resursive?(a, 'a')

# ****************************************************************

# a = Node.new(3)
# b = Node.new(11)
# c = Node.new(4)
# d = Node.new(4)
# e = Node.new(-2)
# f = Node.new(1)

# a.left = b
# a.right = c
# b.left = d
# b.right = e
# c.right = f

# //       3
# //    /    \
# //   11     4
# //  / \      \
# // 4   -2     1

# p tree_sum_recursive(a) # 21
# p tree_sum_iterative(a) # 21

# ****************************************************************

a = Node.new(3)
b = Node.new(11)
c = Node.new(-4)
d = Node.new(4)
e = Node.new(-28)
f = Node.new(1)

a.left = b
a.right = c
b.left = d
b.right = e
c.right = f

# //       3
# //    /    \
# //   11     4
# //  / \      \
# // 4   -2     1

# p tree_min_value(a) # -2
# p tree_min_value_recursive(a)

p max_root_to_leaf(a)
# ****************************************************************