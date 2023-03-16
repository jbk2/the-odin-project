# frozen_string_literal: true

require_relative '../lib/my_enumerables'

RSpec.describe Enumerable do
  subject(:enumerable) { [1, 1, 2, 3, 5, 8, 13, 21, 34] }
  subject(:enumerable2) { [1, 1, 2, 3, 5, 8, 13, nil, 34] }

  describe '#my_all?' do
    context 'when all elements match the condition' do
      it 'returns true' do
        expect(enumerable.my_all? { |value| value > 0 }).to eq true
      end
    end

    context 'when any element does not match the condition' do
      it 'returns false' do
        expect(enumerable.my_all? { |value| value < 5 }).to eq false
      end
    end
    
    context 'returns true if all elements are truthy' do
      it 'returns true' do
        expect([].my_all? { |value| value < 5 }).to eq true
      end
    end
    
    # context 'returns false unless all elements are truthy' do
    #   it 'returns true' do
    #     expect{ enumerable2.my_all? { |value| value < 5 }}.to raise_error(NoMethodError)
    #     # errors.messages[:name].should include("Name cannot be blank")
    #   end
    # end
  end
end
