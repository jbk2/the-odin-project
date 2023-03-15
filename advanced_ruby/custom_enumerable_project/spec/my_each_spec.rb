# frozen_string_literal: true

require_relative '../lib/my_enumerables'

RSpec.describe Array do
  subject(:array) { [1, 1, 2, 3, 5, 8, 13, 21, 34] }

  describe '#my_each' do
    context 'when given a block' do
      it 'returns the original array' do
        my_each_results = array.my_each do |_element|
          # This should return the original array
          # no matter the contents of the block
        end

        expect(my_each_results).to eq(array)
      end

      it 'executes the block for each element' do
        my_each_results = []
        each_results = []

        array.my_each do |element|
          my_each_results << element * 2
        end

        array.each do |element|
          each_results << element * 2
        end

        expect(my_each_results).to eq(each_results)
      end
    end

    # context 'when not given a block' do
    #   it 'returns original array as an Enumerator' do # Currently fails — something to do with Enumerable class not implemnting
    #     # it's own #== method, therefore it's comparing different objects (I don't fully understand, see this discor link:
    #     # https://discord.com/channels/505093832157691914/543074220691947531/1085269829247840397 ).
    #     my_each_results = array.my_each
    #     # This should return an Enumerator
    #     puts "here's my_each_results inspect results: #{my_each_results.inspect}"
    #     puts "here's my_each_results object ID: #{my_each_results.object_id}"
    #     puts "and here's array.each inspect results: #{array.each.inspect}"
    #     puts "and here's array.each object ID: #{array.each.object_id}"
    #     expect(my_each_results).to eq(array.each)
    #   end
    # end
  end
end