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