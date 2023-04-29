require_relative '../lib/tree.rb'
require_relative '../lib/node.rb'
require_relative './support/helpers/helper_module.rb'
include Helpers

describe Tree do
  let(:short_array) { [1, 4, 7, 13, 65, 97]}
  let(:unsorted_array) { [1, 4, 7, 5, 65, 18, 97]}
  let(:duped_array) { [1, 4, 7, 13, 65, 13, 7, 97]}
  let(:large_array) { [503, 237, 821, 75, 351, 630, 927, 37, 192, 257, 442, 567, 737, 879, 967,
    8, 43, 97, 204, 239, 287, 932, 993, 12, 56, 106, 206, 249, 332, 423, 449, 472, 535, 628, 710] }
  let(:level_order_array) { [351, 192, 630, 43, 239, 472, 879, 12, 75, 206, 257, 442, 535, 737,
    932, 8, 37, 56, 97, 204, 237, 249, 287, 423, 449, 503, 567, 710, 821, 927, 967, 106, 332,
    628, 993] }
  let(:tree) { Tree.build_balanced_tree(short_array) }
  let(:large_tree) { Tree.build_balanced_tree(large_array) }

  it "a Tree instance can receieve #build_balanced_tree" do
    expect(tree).to receive(:build_balanced_tree)
    tree.build_balanced_tree
  end

  describe '#build_balanced_tree' do
    context 'given an already sorted short array' do
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
        expect(tree.root.right.value).to equal(65)
      end
    end

    context 'given an unsorted array' do
      let(:tree) { Tree.build_balanced_tree(unsorted_array) }
      
      it 'still builds a balanced tree' do
        expect(tree.root.value).to equal(7)
        expect(tree.root.left.value).to equal(4)
        expect(tree.root.right.value).to equal(65)
      end
    end
    
    context 'given an array with duplicates' do
      let(:tree) { Tree.build_balanced_tree(duped_array) }

      it 'still builds a balanced tree' do
        expect(tree.root.value).to equal(7)
        expect(tree.root.left.value).to equal(1)
        expect(tree.root.right.value).to equal(65)
      end
    end
  end

  describe '#present?()' do
    context 'when value is present' do
      it 'returns true if value is at root' do
        result = tree.node_present?(7)
        expect(result).to be(true)
      end

      it 'returns true if value is a child leaf node' do
        result = tree.node_present?(97)
        expect(result).to be(true)
      end
      
      it 'returns true if value is a child of root with its own children' do
        result = tree.node_present?(65)
        expect(result).to be(true)
      end
    end

    context 'when value is not present' do
      it 'returns false' do
        result = tree.node_present?(6)
        expect(result).to be(false)
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
      it 'deletes a leaf node' do
        tree.delete(13)
        result = tree.node_present?(13)
        expect(result).to be(false)
      end

      it 'deletes a node with one child, whilst leaving tree in correct order' do
        tree.delete(1)
        # tree.nice_print(tree.root)
        expect(tree.node_present?(1)).to be(false)
      end
      
      it 'deletes a node with two children whilst leaving tree in correct order' do
        tree.delete(7)
        # tree.nice_print(tree.root)
        expect(tree.node_present?(7)).to be(false)
      end
    end
  end

  describe '#insert' do
    context 'when insert value is already present' do
      it "prints a warning message" do
        dupe_insert_result = tree.insert(7)
        expect{ tree.insert(7) }.to output("value already present\n").to_stdout
      end
     
      it "returns unaltered tree" do
        dupe_insert_result = tree.insert(7)
        expect(dupe_insert_result).to eq(tree)
      end
    end
    
    context 'when inserted value is > root.value' do
      it "inserts it in root's right subtree" do
        tree.insert(70)
        expect(tree.node_present?(70)).to be(true)
      end
    end
    
    context 'when inserted value is < root.value' do
      it "inserts it in root's left subtree" do
        tree.insert(2)
        expect(tree.node_present?(2)).to be(true)
      end
    end
  end

  describe '#find()' do
    context 'when value is present' do
      it 'returns a node object' do
        result = tree.find(7)
        expect(result).to be_a(Node)
      end
      
      it 'can find and return a root value' do
        result = tree.find(7)
        expect(result).to have_attributes(value: 7)
      end
      it 'can find and return a child node from the left tree' do
        result = tree.find(1)
        expect(result).to have_attributes(value: 1)
      end
      it 'can find and return a child node from the right tree' do
        result = tree.find(97)
        expect(result).to have_attributes(value: 97)
      end
    end
    
    context 'when value is not present' do
      it 'in root it returns false' do
        result = tree.find(8)
        expect(result).to be(false) # or below line to presence test using the present?() helper method
        expect(tree.node_present?(8)).to be(false)
      end
      it 'in left subtree it returns false' do
        result = tree.find(2)
        expect(result).to be(false)
      end
      it 'in right subtree it returns false' do
        result = tree.find(88)
        expect(result).to be(false)
      end
    end
  end

  describe '#level_order' do
    context 'without a block' do
      it "it will return an array of each node's values" do
        result = tree.level_order
        level_order_array = [7, 1, 65, 4, 13, 97]
        expect(result).to eq(level_order_array)
      end

      it "it will return an array of each node's values even with a large array" do
        result = large_tree.level_order
        expect(result).to eq(level_order_array)
      end
    end

    context "with a block" do
      it "yields each node to the block and updates node with block's output" do
        result = tree.level_order.map(&2.method(:*))
        level_order_array = [14, 2, 130, 8, 26, 194]
        expect(result).to eq(level_order_array)
      end
      
      it "yields each node to the block and updates node with block's output" do
        # divmod4 = ->(n) { n.divmod(4) } # could create a lambda
        # result = tree.level_order(&divmod4) #and pass in lambda instead of an explicit block {} argument 
        result = tree.level_order { |value| value.divmod(4) }
        level_order_array = [[1, 3], [0, 1], [16, 1], [1, 0], [3, 1], [24, 1]]
        expect(result).to eq(level_order_array)
      end
    end
  end
  
  describe '#pre_order' do
    context 'without a block' do
      pre_order_array = [7, 1, 4, 65, 13, 97]
      pre_order_large_array = [351, 192, 43, 12, 8, 37, 75, 56, 97, 106, 239, 206, 204, 237, 257,
        249, 287, 332, 630, 472, 442, 423, 449, 535, 503, 567, 628, 879, 737, 710, 821, 932, 927,
        967, 993]
        
        it "it will return an array of correctly pre-ordered values" do
          result = tree.pre_order
          expect(result).to eq(pre_order_array)
      end
      
      it "it will return an array of correctly pre-ordered values, even with a large array" do
        result = large_tree.pre_order
        expect(result).to eq(pre_order_large_array)
      end
    end
    
    context "with a block" do
      pre_order_array_doubled = [14, 2, 8, 130, 26, 194]
      
      it "returns block output values ib correct pre-order" do
        result = tree.pre_order { |value| value * 2 } 
        expect(result).to eq(pre_order_array_doubled)
      end
    end
  end
  
  describe '#in_order' do
    context 'without a block' do
      in_order_array = [1, 4, 7, 13, 65, 97]
      in_order_large_array = [8, 12, 37, 43, 56, 75, 97, 106, 192, 204, 206, 237, 239, 249, 257,
      287, 332, 351, 423, 442, 449, 472, 503, 535, 567, 628, 630, 710, 737, 821, 879, 927, 932,
      967, 993]
      
      it "will return an array of correctly in-ordered values" do
        result = tree.in_order
        expect(result).to eq(in_order_array)
      end
      
      it "will return an array of correctly in-ordered values, even with a large array" do
        result = large_tree.in_order
        expect(result).to eq(in_order_large_array)
      end
    end
    
    context "with a block" do
      it "returns block output values in correct in-order" do
        in_order_array_doubled = [2, 8, 14, 26, 130, 194]
        result = tree.in_order { |values| values * 2 } 
        expect(result).to eq(in_order_array_doubled)
      end
    end
  end

  describe '#post_order' do
    context 'without a block' do
      post_order_array = [4, 1, 13, 97, 65, 7]
      post_order_large_array = [8, 37, 12, 56, 106, 97, 75, 43, 204, 237, 206, 249, 332, 287,
        257, 239, 192, 423, 449, 442, 503, 628, 567, 535, 472, 710, 821, 737, 927, 993, 967, 932,
        879, 630, 351]

      it "it will return an array of correctly post-ordered values" do
        result = tree.post_order
        expect(result).to eq(post_order_array)
      end

      it "it will return an array of correctly post-ordered values, even with a large array" do
        result = large_tree.post_order
        expect(result).to eq(post_order_large_array)
      end
    end

    context "with a block" do
      it "returns block output values in correct post-order" do
        post_order_array_doubled = [8, 2, 26, 194, 130, 14]
        result = tree.post_order { |v| v * 2 } 
        expect(result).to eq(post_order_array_doubled)
      end
    end
  end

  # describe '#height' do
  #   context 'when value is not present' do
  #     it 'prints a statement declaring not value not present' do
  #       expect { tree.height(6) }.to output("value not present\n").to_stdout
  #     end 
  #   end

    # context 'when value is present' do
    #   xit 'returns the height of the value' do
    #     result = tree.height(7)
    #     expect(result).to equal(2)
    #   end 
    # end
  # end
  
  describe '#depth' do
    context 'when value is present in left subtree' do
      it 'returns depth 0 given a node value at level 0' do
        result = tree.depth(7)
        expect(result).to eq(0)
      end 
      
      it 'returns depth 1 given a node valye at level 1' do
        result = tree.depth(1)
        expect(result).to eq(1)
      end 
      
      it 'returns depth 2 given a node valye at level 2' do
        result = tree.depth(4)
        expect(result).to eq(2)
      end 

      it 'returns depth 2 given a node valye at level 2' do
        result = large_tree.depth(8)
        expect(result).to eq(4)
      end 
    end
    
    context 'when value is present in right subtree' do
      it 'returns depth 1 given a node valye at level 1' do
        result = tree.depth(65)
        expect(result).to eq(1)
      end 
      
      it 'returns depth 2 given a node valye at level 2' do
        result = tree.depth(13)
        expect(result).to eq(2)
      end 

      it 'returns depth 3 given a node valye at level 3' do
        result = large_tree.depth(932)
        expect(result).to eq(3)
      end
      
      it 'returns depth 4 given a node valye at level 4' do
        result = large_tree.depth(967)
        expect(result).to eq(4)
      end 
      
      it 'returns depth 5 given a node valye at level 5' do
        result = large_tree.depth(993)
        expect(result).to eq(5)
      end 
    end
  end
end