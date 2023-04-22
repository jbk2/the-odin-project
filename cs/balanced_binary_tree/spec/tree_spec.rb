require_relative '../lib/tree.rb'

describe Tree do
  let(:short_array) { [1, 4, 7, 13, 65, 97]}
  let(:unsorted_array) { [1, 4, 7, 5, 65, 18, 97]}
  let(:array_dups) { [1, 4, 7, 13, 65, 13, 7, 97]}
  let(:long_array) { Array.new(50) { rand(1..999) } }
  let(:tree) { Tree.build_balanced_tree(short_array) }
  

  it "a Tree instance can receieve #build_balanced_tree" do
    expect(tree).to receive(:build_balanced_tree)
    tree.build_balanced_tree
  end

  describe '#build_balanced_tree' do
    context 'given an already sorted short array' do
      # before do
      #   tree.build_balanced_tree(short_array)
      # end

      it "creates a root node with middle of array's value" do
        array_mid_val = (short_array.length - 1) / 2
        expect(tree.root.value). to eq(7)
      end

      it 'expects a root node to be an instance of Node' do
        expect(tree.root).to be_a(Node)
      end

      it "gives tree's root a left Node" do
        expect(tree.root.left).to be_a(Node)
      end
    
      it "gives tree's root a right Node" do
        expect(tree.root.right).to be_a(Node)
      end
      
      it "gives root's left Node's value as 1" do
        expect(tree.root.left.value).to equal(1)
      end
    
      it "gives root's right Node's value as 65" do
        # puts long_array
        expect(tree.root.right.value).to equal(65)
      end
    end
  end

  describe '#delete(val)' do
    context 'when value is not present' do
      it "returns the unchanged tree" do
        expect(tree.delete(2)).to eq(tree.root) 
      end
    end
    
    context 'when value is present' do
      it 'deletes a leadf node leaving tree in correct order' do
      end
      it 'deletes a node with one child, whilst leaving tree in correct order' do
      end
      it 'deletes a node with two children whilst leaving tree in correct order' do
      end
    end
  end
end