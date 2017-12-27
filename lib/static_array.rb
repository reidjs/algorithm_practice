# This class just dumbs down a regular Array to be statically sized.
class StaticArray
  attr_reader :length 
  def initialize(length)
    @store = {}
    @length = length 
  end

  # O(1)
  def [](index)
    check_bounds(index)
    @store[index]
  end
  def check_bounds(index)
    raise "index out of bounds" if index > @length || index < 0
  end 
  # O(1)
  def []=(index, value)
    check_bounds(index)
    @store[index] = value
  end

  protected
  attr_accessor :store
end

# x = StaticArray.new(8)
# x[0] = 'a'
# p x[0]
