require_relative "static_array"

class DynamicArray
  attr_reader :length

  def initialize
    @length = 0
    @capacity = 8
    @store = StaticArray.new(@capacity)
  end

  # O(1)
  def [](index)
    # p "idx:#{index} length: #{@length}"
    raise "index out of bounds" if index >= @length 
    @store[index]
  end

  # O(1)
  def []=(index, value)
    raise "index out of bounds" if index >= @length || index < 0
    @store[index] = value
  end

  # O(1)
  def pop
    # raise "idnex out of bounds" if @length == 0
    val = self[@length-1]
    @length -= 1
    val 
  end

  # O(1) ammortized; O(n) worst case. Variable because of the possible
  # resize.
  def push(val)
    @length += 1
    resize! if @length > @capacity
    self[@length-1] = val
    # @capacity += 1
  end

  # O(n): has to shift over all the elements.
  #move every element left 
  def shift
    # return nil if @length < 1
    val = self[0]
    new_arr = DynamicArray.new 
    i = 1
    while i < @length do 
      new_arr.push(self[i])
      i += 1
    end 
    @store = new_arr
    @length -= 1
    val 
  end

  # O(n): has to shift over all the elements.
  def unshift(val)
    @length += 1
    i = 0
    new_arr = DynamicArray.new
    new_arr.push(val)
    while i < @length do 
      new_arr.push(@store[i])
      i += 1
    end 
    @store = new_arr
  end

  protected
  attr_accessor :capacity, :store
  attr_writer :length

  def check_index(index)
  end

  # O(n): has to copy over all the elements to the new store.
  def resize!
    # raise "resize not implemented"
    # @temp_store = []
    # @store.each do |el|
      
    # end 
    # @capacity = @capacity * /2 
    @capacity = @capacity * 2
    new_store = StaticArray.new(@capacity)
    i = 0
    while i < @length 
      new_store[i] = @store[i]
      i += 1
    end 
    @store = new_store 
  end
end
