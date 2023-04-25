module Helpers

  def node_present?(root = @root, value)
    if value == root.value
      return true 
    elsif value < root.value && root.left
      node_present?(root.left, value)
    elsif value > root.value && root.right
      node_present?(root.right, value)
    else
      return false
    end
  end

end