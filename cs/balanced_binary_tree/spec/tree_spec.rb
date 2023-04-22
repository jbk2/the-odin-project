require_relative '../lib/tree.rb'
require_relative '../lib/node.rb'

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
  end

  describe '#present?()' do
    context 'when value is present' do
      it 'returns true if value is at root' do
        result = tree.present?(7)
        expect(result).to be(true)
      end

      it 'returns true if value is a child leaf node' do
        result = tree.present?(97)
        expect(result).to be(true)
      end
      
      it 'returns true if value is a child of root with its own children' do
        result = tree.present?(65)
        expect(result).to be(true)
      end
    end

    context 'when value is not present' do
      it 'returns false' do
        result = tree.present?(6)
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
        result = tree.present?(13)
        expect(result).to be(false)
      end

      it 'deletes a node with one child, whilst leaving tree in correct order' do
        tree.delete(1)
        # tree.nice_print(tree.root)
        expect(tree.present?(1)).to be(false)
      end
      
      it 'deletes a node with two children whilst leaving tree in correct order' do
        tree.delete(7)
        # tree.nice_print(tree.root)
        expect(tree.present?(7)).to be(false)
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
        expect(tree.present?(70)).to be(true)
      end
    end
    
    context 'when inserted value is < root.value' do
      it "inserts it in root's left subtree" do
        tree.insert(2)
        # tree.insert(3)
        tree.nice_print(tree.root)
        expect(tree.present?(2)).to be(true)
      end
    end
  end

end