require 'pry-byebug'
require 'pp'

class Node
  attr_accessor :value, :left, :right
  
  def initialize(value)
    @value = value
    @left = nil
    @right = nil
  end

  def self.build_balanced_tree(array)
    array = array.sort.uniq
    return if array.empty?

    array_mid_index = (array.length - 1) / 2
    node = Node.new(array[array_mid_index])
    node.left = build_balanced_tree(array.slice(0, array_mid_index))
    node.right = build_balanced_tree(array[(array_mid_index + 1)..(array.length - 1)])
    return node
  end
end

class Tree
  attr_reader :root

  def initialize(array)
    @root = Node.build_balanced_tree(array)
  end
  
  def self.build_balanced_tree(array)
    tree = Tree.new(array)
    return tree
  end

  def delete(value)
    @root = @root&.delete(value)
  end

  def delete(root, value)
    return root if root.nil?

    if value < root.value
      root.left = delete(root.left, value)
    elsif value > root.value
      root.right = delete(root.right, value)
    else root.value == value 
      puts 'must have found the value'
      if root.left.nil? && root.right.nil?  # case 1 - no children, just delete
        root = nil    
      elsif root.left.nil? # case 2 - one child, just delete and replace with child
        root = root.right
      elsif root.right.nil?
        root = root.left
      else # case 3 - 2 chilren, find max value in left subtree and replace with this
        min_node = min_value(root.right)
        root.value = min_node.value
        root.right = delete(root.right, min_value(root.right).value)
      end
    end
    return root
  end

  def min_value(root)
    current = root
    current = current.left until current.left.nil?
    return current
  end

  def nice_print(node, prefix = '', is_left = true)
    nice_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── ' }#{node.value}"
    nice_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end

end


  array = [1, 4, 7, 13, 65, 97]
  array_2 = Array.new(15) { rand(1..99) }
  array_3 = [83, 65, 99, 36, 7, 90, 25, 95, 68, 39, 96, 13, 75, 89, 2]
  tree = Tree.build_balanced_tree(array_3)
  pp tree
  tree.nice_print(tree.root)
  pp tree.delete(tree.root, 25)
  tree.nice_print(tree.root)
