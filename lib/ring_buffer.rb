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
    # raise "index out of bounds" if index >= length || index < 0
    # p self[6]
    converted_idx = (@start_idx + index) % capacity
    p "#{@start_idx} #{index} #{capacity}, converted: #{converted_idx}, val: #{@store[converted_idx]}"
    # p @store[6]
    @store[converted_idx]
  end

  # O(1)
  def []=(index, val)
    # converted_idx = (@start_idx % @capacity)
    # p "index #{index} is equal to index #{converted_idx}"
    converted_idx = (@start_idx + index) % capacity
    # p "setting #{converted_idx} to #{val}"
    @store[converted_idx] = val
    # p "check: #{self[index]}"
  end

  # O(1)
  def pop
    # val = 
    @length -= 1
  end

  # O(1) ammortized
  def push(val)
    @length += 1
    last_idx = @length - 1
    self[last_idx] = val
  end

  # O(1)
  def shift
    val = self[0]
    @start_idx += 1
    @length -= 1
    # p "shifted #{val}"
    val 
  end

  # O(1) ammortized
  def unshift(val)
    # first_idx = @start_idx
    @start_idx -= 1
    @length += 1
    # p first_idx
    p "unshifting #{val}"
    self[0] = val
    p "the first index is now: #{self[0]}"
  end

  protected
  attr_accessor :capacity, :start_idx, :store
  attr_writer :length

  def check_index(index)
  end

  def resize!
  end
end

arr = RingBuffer.new
