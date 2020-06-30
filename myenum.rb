module Enumerable
  def my_each
    return to_enum unless block_given?
    arr = is_a?(Range) || (Hash) ? self.to_a : self
    i = 0
    while i < arr.length
      if is_a?(Hash)
        yield(arr[i]) && yield(arr[i][0], arr[i][1])
      else
        yield(arr[i])
      end
      i += 1
    end
    self
  end

  def my_each_with_index
    return to_enum unless block_given?
    arr = is_a?(Range) || (Hash) ? self.to_a : self
    i = 0
    while i < arr.length
      yield((arr[i]), i) 
      i += 1
    end
    self
  end

  def my_select
    return to_enum unless block_given?
    array = is_a?(Range) || (Hash) ? self.to_a : self
    new_arr = []
    array.my_each { |val| new_arr << val if yield(val) } 
    new_arr
  end

  def my_all?(arg = nil)
    array = is_a?(Range) || (Hash) ? self.to_a : self
    check = true
    if block_given?    
      array.my_each { |value| check = false unless yield(value)}
    elsif arg.is_a?(Class)
      array.my_each {|value| check = false unless value.class.ancestors.include?(arg) }
    elsif arg.is_a?(Regexp)
      array.my_each {|value| check = false unless value.match(arg) }
    else
      array.my_each { |value| check = false if !value == true}
    end 
    check    
  end

  def my_any?(arg = nil)
    array = is_a?(Range) || (Hash) ? self.to_a : self
    check = false
    if block_given?    
      array.my_each { |value| check = true if yield(value)}
    elsif arg.is_a?(Class)
      array.my_each {|value| check = true if value.class.ancestors.include?(arg) }
    elsif arg.is_a?(Regexp)
      array.my_each {|value| check = true if value.match(arg) }
    else
      array.my_each { |value| check = true if value == true}
    end 
    check    
  end

end

def multiply_els(arr)
  arr.my_inject(:*)
end

my_proc = proc {|x| x**3 }

puts multiply_els(1..5)