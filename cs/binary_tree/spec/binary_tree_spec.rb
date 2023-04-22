require_relative '../lib/binary_tree.rb'

describe BinaryTree do

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

  let(:bt) { BinaryTree.new(a) }

  describe '#max_root_to_leaf' do
    it 'identifies max root to leaf value as 18' do
      result = bt.max_root_to_leaf(bt.root)
      expect(result).to eq(18)
    end
  end
end