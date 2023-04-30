require_relative 'node'

class Tree
  attr_accessor :root

  def initialize(array)
    @root = build_tree(array)
  end
  
# Write a #build_tree method which takes an array of data (e.g. [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324])
# and turns it into a balanced binary tree full of Node objects appropriately placed
# (don’t forget to sort and remove duplicates!).
# The #build_tree method should return the level-0 root node.
  def build_tree(array)
    array = array.sort.uniq
    return if array.empty?

    array_mid_index = (array.length - 1) / 2
    node = Node.new(array[array_mid_index])
    node.left = build_tree(array.slice(0, array_mid_index))
    node.right = build_tree(array[(array_mid_index + 1)..(array.length - 1)])
    return node
  end
  
# Write an #insert and #delete method which accepts a value to insert/delete
# (you’ll have to deal with several cases for delete such as when a node has children or not).
  def insert(root = @root, value)
    if value == root.value
      puts "value already present"
    elsif value < root.value
      root.left ? insert(root.left, value) : root.left = Node.new(value)
    elsif value > root.value
      root.right ? insert(root.right, value) : root.right = Node.new(value)
    end
    return self
  end

  def delete(value)
    @root = delete_rec(@root, value)
  end

# Write a #find method which accepts a value and returns the node with the given value.
  def find(root = @root, value)
    if value == root.value
      return root
    elsif root.left && value < root.value 
      find(root.left, value)
    elsif root.right && value > root.value
      find(root.right, value)
    else
      return false
    end
  end

# Write a #level_order method which accepts a block. This method should traverse the tree
# in breadth-first level order and yield each node to the provided block.
#  The method should return an array of values if no block is given.
# Breadth first: level order traversal
  def level_order(root = @root, queue = [], values = [])
    # return values if root.nil?# : queue.append(root)
    queue.append(root)
    while queue.count > 0
      current = queue.pop
      block_given? ? values << yield(current.value) : values << current.value
      queue.prepend(current.left) if current.left
      queue.prepend(current.right) if current.right
    end
    return values
  end

# Write #inorder, #preorder, and #postorder methods that accepts a block. Each method should
# traverse the tree in their respective depth-first order and yield each node to the provided block.
# The methods should return an array of values if no block is given.

# Depth first - Pre-order traversal, <root> <left> <right>, DLR D(ata) L(eft) R(ight)
  def pre_order(root = @root, values = [], &block)
    return if root.nil?
    # my_proc = yield.to_proc
    block_given? ? values << block.(root.value) : values << root.value #block.call() || block.()
    pre_order(root.left, values, &block) if root.left
    pre_order(root.right, values, &block) if root.right
    values
  end

# Depth first - In-order traversal, <left> <root> <right>, LDR L(eft) D(ata) R(ight)
  def in_order(root = @root, values = [], &block)
    return if root.nil?
    in_order(root.left, values, &block)
    block_given? ? values << yield(root.value) : values << root.value #can ues yield wiht implicitly given block as well as block.call / block.
    in_order(root.right, values, &block)
    values
  end

	
# Depth first = Post-order traversal, <left> <right> <root>, LRD L(eft) R(ight) D(ata)
  def post_order(root = @root, values = [], &block)
    return if root.nil?
    post_order(root.left, values, &block)
    post_order(root.right, values, &block)
    block_given? ? values << block.call(root.value): values << root.value
  end

# Write a #depth method which accepts a node and returns its depth. Depth is defined as the
# number of edges in path from a given node to the tree’s root node.
  def depth(root = @root, level = 0, node)
    if node == root
      return level
    elsif root.left && node.value < root.value
      depth(root.left, level += 1, node)
    elsif root.right && node.value > root.value
      depth(root.right, level += 1, node)
    else
      return -1
    end
  end

# Write a #height method which accepts a node and returns its height. Height is defined as
# the number of edges in longest path from a given node to a leaf node.
  def height(node, level = 0)
    return level if node.nil? || (node.left.nil? && node.right.nil?)
    level += 1
    ([height(node.left, level), height(node.right, level) ].max)
  end
  
# Write a #balanced? method which checks if the tree is balanced. A balanced tree is one
# where the difference between heights of left subtree and right subtree of every
# node is not more than 1.
  def balanced?(root = @root)
    left_height = height(root.left)
    right_height = height(root.right)
    difference = left_height - right_height
    difference < 2 && difference > -2 ? true : false
  end

# Write a #rebalance method which rebalances an unbalanced tree. Tip: You’ll want
# to use a traversal method to provide a new array to the #build_tree method.
  def rebalance(root = @root)
    values_array = self.in_order
    self.root = build_tree(values_array)
  end

  def nice_print(node, prefix = '', is_left = true)
    nice_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── ' }#{node.value}"
    nice_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
  
  private
  def children?(node)
    return true if node.left || node.right
    return false
  end

  def delete_rec(root, value)
    return root if root.nil?
  
    if value < root.value
      root.left = delete_rec(root.left, value)
    elsif value > root.value
      root.right = delete_rec(root.right, value)
    else root.value == value
      if root.left.nil? && root.right.nil?  # case 1 - no children, just delete
        root = nil    
      elsif root.left.nil? # case 2 - one child, just delete and replace with child
        root = root.right
      elsif root.right.nil?
        root = root.left
      else # case 3 - 2 chilren, find max value in left subtree and replace with this
        min_node = min_value(root.right)
        root.value = min_node.value
        root.right = delete_rec(root.right, min_value(root.right).value)
      end
    end
    return root
  end

  def min_value(root)
    current = root
    current = current.left until current.left.nil?
    return current
  end
end

  array = [1, 4, 7, 13, 65, 97]
  large_array = [503, 237, 821, 75, 351, 630, 927, 37, 192, 257, 442, 567, 737, 879, 967,
  8, 43, 97, 204, 239, 287, 932, 993, 12, 56, 106, 206, 249, 332, 423, 449, 472, 535, 628, 710]
  # array_2 = Array.new(15) { rand(1..99) }
  # array_3 = [83, 65, 99, 36, 7, 90, 25, 95, 68, 39, 96, 13, 75, 89, 2]
  # tree = Tree.new(array)
  # tree.nice_print(tree.root)
