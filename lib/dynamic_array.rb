require_relative "static_array"

class DynamicArray
  attr_reader :length

  def initialize
    @length = 0
    @store = []
    @capacity = 8
  end

  # O(1)
  def [](index)
    raise "index out of bounds" if index >= @length
    @store[index]
  end

  # O(1)
  def []=(index, value)
    @store[index] = value
  end

  # O(1)
  def pop
    raise "index out of bounds" if @store.empty?
    @length -= 1
    @store.pop
  end

  # O(1) ammortized; O(n) worst case. Variable because of the possible
  # resize.
  def push(val)
    @length += 1
    resize! if @length > capacity
    @store << val
    # @capacity += 1
  end

  # O(n): has to shift over all the elements.
  def shift
    raise "index out of bounds" if @store.empty?

    @length -= 1
    @store.shift 
  end

  # O(n): has to shift over all the elements.
  def unshift(val)
    @length += 1
    @store.unshift(val)
  end

  protected
  attr_accessor :capacity, :store
  attr_writer :length

  def check_index(index)
  end

  # O(n): has to copy over all the elements to the new store.
  def resize!
    # @temp_store = []
    # @store.each do |el|
      
    # end 
    @capacity = @capacity * 2 
  end
end
