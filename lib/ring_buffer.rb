require_relative "static_array"

class RingBuffer
  attr_reader :length

  def initialize
    @length = 0
    @start_idx = 0
    @capacity = 8
    @store = StaticArray.new(@capacity)
  end


  # O(1)
  def [](index)
    raise "index out of bounds" if index >= @length || index < 0
    # p self[6]
    converted_idx = (@start_idx + index) % capacity
    # p "#{@start_idx} #{index} #{capacity}, converted: #{converted_idx}, val: #{@store[converted_idx]}"
    # raise "index out of bounds" if converted_idx < @start_idx || converted_idx > @start_idx + @length
    # p @store[6]
    @store[converted_idx]
  end

  # O(1)
  def []=(index, val)
    
    # converted_idx = (@start_idx % @capacity)
    # p "index #{index} is equal to index #{converted_idx}"
    converted_idx = (@start_idx + index) % capacity
    # raise "index out of bounds" if converted_idx < @start_idx || converted_idx > @start_idx + @length
    # p self[converted_idx]
    # p "setting #{converted_idx} to #{val}"
    @store[converted_idx] = val
    # p "check: #{self[index]}"
  end

  # O(1)
  def pop
    raise "index out of bounds" if @length < 1
    val = self[@length - 1]
    @length -= 1
    val 
  end

  # O(1) ammortized
  def push(val)
    # raise "pop does not resize"
    resize! if (@length + 1) > @capacity 
    @length += 1
    last_idx = @length - 1
    self[last_idx] = val
  end

  # O(1)
  def shift
    raise "index out of bounds" if @length < 1

    val = self[0]
    @start_idx += 1
    @length -= 1
    # p "shifted #{val}"
    val 
  end

  # O(1) ammortized
  def unshift(val)
    # raise "unshift does not resize "
    # first_idx = @start_idx
    resize! if (@length + 1) > @capacity 
    @start_idx -= 1
    @length += 1
    # p first_idx
    # p "unshifting #{val}"
    self[0] = val
    # p "the first index is now: #{self[0]}"
  end

  protected
  attr_accessor :capacity, :start_idx, :store
  attr_writer :length

  def check_index(index)
  end

  def resize!
    new_capacity = @capacity * 2
    new_store = StaticArray.new(new_capacity)
    i = 0
    while i < @length 
      new_store[i] = self[i]
      i += 1
    end   
    @capacity = new_capacity
    @start_idx = 0
    @store = new_store
  end
end

arr = RingBuffer.new
