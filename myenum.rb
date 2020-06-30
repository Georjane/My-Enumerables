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

  def my_none?(arg = nil)
    array = is_a?(Range) || (Hash) ? self.to_a : self
    check = true
    if block_given?    
      array.my_each { |value| check = false if yield(value)}
    elsif arg.is_a?(Class)
      array.my_each {|value| check = false if value.class.ancestors.include?(arg) }
    elsif arg.is_a?(Regexp)
      array.my_each {|value| check = false if value.match(arg) }
    else
      array.my_each { |value| check = false if value == true}
    end 
    check    
  end

  def my_count(arg = nil)
    array = is_a?(Range) || (Hash) ? self.to_a : self
    count = 0
    if block_given?
      array.my_each {|value| count += 1 if yield(value)}
    elsif !arg.nil?
      array.my_each {|value| count += 1 if value == arg}
    else
      count = array.size
    end
    count
    
  end

  def my_map(&proc)
    return to_enum unless block_given?
    array = is_a?(Range) || (Hash) ? self.to_a : self
    results = []
    if proc.nil?
      array.my_each { |value| results << yield(value)}
    else    
      array.my_each { |value| results << proc.(value)}
    end
    results    
  end

  def my_inject(*args)
    array = is_a?(Range) || (Hash) ? self.to_a : self
    memo = array[0]
    if block_given?
      if args[0].nil?
        array.drop(1).my_each {|value| memo = yield(memo, value)}
      else
        memo = args[0]
        array.my_each {|value| memo = yield(memo, value)}
      end
    else
      if args[1].nil?
        symbol = args[0]
        array.drop(1).my_each {|value| memo = memo.send(symbol, value)}
      else
        memo = args[0]
        symbol = args[1]
        array.my_each {|value| memo = memo.send(symbol, value)}
      end
    end
    memo
  end
end

def multiply_els(arr)
  arr.my_inject(:*)
end

my_proc = proc {|x| x**3 }

puts multiply_els(1..5)