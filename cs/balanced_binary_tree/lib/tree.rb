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

  def insert(node = @root, value)
    if value == node.value
      puts "value already present"
    elsif value < node.value
      node.left ? insert(node.left, value) : node.left = Node.new(value)
    elsif value > node.value
      node.right ? insert(node.right, value) : node.right = Node.new(value)
    end
    return self
  end

  def find(node = @root, value)
    if value == node.value
      return node
    elsif node.left && value < node.value 
      find(node.left, value)
    elsif node.right && value > node.value
      find(node.right, value)
    else
      return false
    end
  end

  def level_order(node = @root, queue = [], values = [])
    # return values if node.nil?# : queue.append(node)
    queue.append(node)
    while queue.count > 0
      current = queue.pop
      block_given? ? values << yield(current.value) : values << current.value
      queue.prepend(current.left) if current.left
      queue.prepend(current.right) if current.right
    end
    return values
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
  tree = Tree.build_balanced_tree(large_array)
  # # tree = Tree.build_balanced_tree(array_2)
  # # tree = Tree.build_balanced_tree(array_3)
  # pp tree
  tree.nice_print(tree.root)
  # pp tree.delete(13)
  # pp tree.present?(65)
  tree.insert(70)
  tree.nice_print(tree.root)