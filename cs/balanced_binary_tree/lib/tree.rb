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
    elsif value < root.value
      find(root.left, value)
    elsif value > root.value
      find(root.right, value)
    else
      return false
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
  # array_2 = Array.new(15) { rand(1..99) }
  # array_3 = [83, 65, 99, 36, 7, 90, 25, 95, 68, 39, 96, 13, 75, 89, 2]
  tree = Tree.build_balanced_tree(array)
  # # tree = Tree.build_balanced_tree(array_2)
  # # tree = Tree.build_balanced_tree(array_3)
  # pp tree
  tree.nice_print(tree.root)
  # pp tree.delete(13)
  # pp tree.present?(65)
  tree.insert(70)
  tree.nice_print(tree.root)