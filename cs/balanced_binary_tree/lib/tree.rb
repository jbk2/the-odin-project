require 'pry-byebug'
require_relative 'node'

class Tree
  attr_accessor :root

  def initialize(array)
    @root = Node.build_balanced_tree(array)
  end
  
  def self.build_balanced_tree(array)
    tree = Tree.new(array)
    return tree
  end

  def delete(value)
    @root = delete_rec(@root, value)
  end

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

  def depth(root = @root, level = 0, value)
    return -1 if root.nil?
    if root.value == value
      return level
    elsif root.left && value < root.value
      depth(root.left, level += 1, value)
    elsif root.right && value > root.value
      depth(root.right, level += 1, value)
    end
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

# ____________________

  array = [1, 4, 7, 13, 65, 97]
  large_array = [503, 237, 821, 75, 351, 630, 927, 37, 192, 257, 442, 567, 737, 879, 967,
  8, 43, 97, 204, 239, 287, 932, 993, 12, 56, 106, 206, 249, 332, 423, 449, 472, 535, 628, 710]
  # array_2 = Array.new(15) { rand(1..99) }
  # array_3 = [83, 65, 99, 36, 7, 90, 25, 95, 68, 39, 96, 13, 75, 89, 2]
  # tree = Tree.build_balanced_tree(array)
  tree = Tree.build_balanced_tree(large_array)
  # # tree = Tree.build_balanced_tree(array_2)
  # # tree = Tree.build_balanced_tree(array_3)
  # pp tree
  tree.nice_print(tree.root)
  # pp tree.delete(13)
  # pp tree.present?(65)
  # tree.insert(70)
  # tree.nice_print(tree.root)