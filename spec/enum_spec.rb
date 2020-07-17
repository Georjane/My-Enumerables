require 'rubygems'
require 'bundler/setup'

require 'rspec'
require './lib/myenum'

describe Enumerable do
  let(:arr) { 1..3 }
  let(:animals) { %w[ant bear cat] }

  describe '#my_each()' do
    it 'returns self of object passed to it' do
      expect(arr.my_each { |x| x * 2 }).to eq 1..3
    end
  end

  describe '#my_each_with_index' do
    it 'returns self of object passed to it' do
      expect(arr.my_each_with_index { |x, y| x + y }).to eq 1..3
    end
  end

  describe '#my_select' do
    it 'returns a new array containing all numbers which the given block returns a true value' do
      selected_values = []
      expect([1, 2, 3, 4, 5].select { |num| selected_values << num if num.even? }).to eq selected_values
    end

    it 'returns a new array containing all elements which the given block returns a true value' do
      a = %w[a b c d e f]
      expect(a.my_select { |v| v =~ /[aeiou]/ }).to eq %w[a e]
    end
  end

  describe '#my_all?(*arg)' do
    it 'returns true if the block never returns false or nil and all elements are true' do
      expect(animals.my_all? { |word| word.length >= 3 }).to be true
    end

    it 'returns true if the block never returns false or nil and all elements are true' do
      expect(animals.my_all? { |word| word.length >= 4 }).to be false
    end

    it 'returns true if the block never returns false or nil and all elements are true' do
      expect(animals.my_all?(/t/)).to be false
    end

    it 'returns true if the block never returns false or nil and all elements are true' do
      expect([1, 2i, 3.14].my_all?(Numeric)).to be true
    end

    it 'returns true if the block never returns false or nil and all elements are true' do
      expect([nil, true, 99].my_all?).to be false
    end

    it 'returns true if the block never returns false or nil and all elements are true' do
      expect([].my_all?).to be true
    end
  end

  describe '#my_any?(*arg)' do
    it 'returns true if any element is true' do
      expect(animals.my_any? { |word| word.length >= 3 }).to be true
    end

    it 'returns true if any element is true' do
      expect(animals.my_any? { |word| word.length >= 4 }).to be true
    end

    it 'returns true if any element is true' do
      expect(animals.my_any?(/d/)).to be false
    end

    it 'returns true if any element is true' do
      expect([nil, true, 99].my_any?(Integer)).to be true
    end

    it 'returns true if any element is true' do
      expect([nil, true, 99].my_any?).to be true
    end

    it 'returns true if any element is true' do
      expect([].my_any?).to be false
    end
  end

  describe '#my_none?(*args)' do
    it 'returns true if no element is true' do
      expect(animals.my_none? { |word| word.length == 5 }).to be true
    end

    it 'returns true if no element is true' do
      expect(animals.my_none? { |word| word.length >= 4 }).to be false
    end

    it 'returns true if no element is true' do
      expect(animals.my_none?(/d/)).to be true
    end

    it 'returns true if no element is true' do
      expect([1, 3.14, 42].none?(Float)).to be false
    end

    it 'returns true if no element is true' do
      expect([nil, false, true].my_none?).to be false
    end

    it 'returns true if no element is true' do
      expect([nil, false].my_none?).to be true
    end

    it 'returns true if no element is true' do
      expect([nil].my_none?).to be true
    end

    it 'returns true if no element is true' do
      expect([].my_none?).to be true
    end
  end

  describe '#my_count(p1)' do
    ary = [1, 2, 4, 2]
    it 'returns the number of elements' do
      expect(ary.my_count).to eql 4
    end

    it 'returns the number of elements' do
      expect(ary.my_count(2)).to eql 2
    end

    it 'returns the number of elements' do
      expect(ary.my_count(&:even?)).to eql 3
    end
  end

  describe '#my_map()' do
    it 'returns a new array with the results of running block once for every element in enum' do
      expect((1..4).my_map { |i| i * i }).to eql [1, 4, 9, 16]
    end

    it 'returns a new array with the results of running block once for every element in enum' do
      expect((1..4).my_map { 'cat' }).to eql %w[cat cat cat cat]
    end
  end

  describe '#my_inject(p1 = v1, p2 = v2)' do
    it 'Combines all elements of enum' do
      expect((5..10).my_inject(:+)).to eql 45
    end

    it 'Combines all elements of enum' do
      expect((5..10).my_inject { |sum, n| sum + n }).to eql 45
    end

    it 'Combines all elements of enum' do
      expect((5..10).my_inject(1, :*)).to eql 151_200
    end

    it 'Combines all elements of enum' do
      expect((5..10).my_inject(1) { |product, n| product * n }).to eql 151_200
    end

    it 'Combines all elements of enum' do
      longest = %w[cat sheep bear].my_inject do |memo, word|
        memo.length > word.length ? memo : word
      end
      expect(longest).to eql 'sheep'
    end
  end

  describe '#multiply_els(arr)' do
    it 'returns the product of elements in an array' do
      expect(multiply_els([1, 2, 3])).to be 6
    end
  end
end
