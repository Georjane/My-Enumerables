require './lib/myenum'

describe Enumerable do
  describe ".my_each" do
    # it "returns to enum if no block given" do 
    #   expect([1,2,3].my_each).to eql(Enumerator: [1, 2, 3]:my_each)
    # end

    it "returns self of object passed to it" do 
      expect([1,2,3].my_each{|x| puts x*2}).to eq ([1,2,3])
    end
  end
end