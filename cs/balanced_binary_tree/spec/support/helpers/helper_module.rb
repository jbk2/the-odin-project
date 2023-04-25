module Helpers

  def node_present?(root = @root, value)
    if value == root.value
      return true 
    elsif root.left && value < root.value
      node_present?(root.left, value)
    elsif root.right && value > root.value 
      node_present?(root.right, value)
    else
      return false
    end
  end

end