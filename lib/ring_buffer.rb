require_relative "static_array"

class RingBuffer
  attr_reader :length

  def initialize
    @store = []
    @length = 0
    @start_idx = 0
    @capacity = 8
  end

  # O(1)
  def [](index)
    raise "index out of bounds" if index >= length
    @store[@start_idx + index]
  end

  # O(1)
  def []=(index, val)
  end

  # O(1)
  def pop
    if @length > 0
      val = @store[length - 1]
      @length -= 1
    end 
  end

  # O(1) ammortized
  def push(val)
    @length += 1
    p @start_idx % @capacity + @length
    @store[@start_idx % @capacity + @length - 1] = val
  end

  # O(1)
  def shift
    val = @store[@start_idx % @capacity]
    @length -= 1
    @start_idx += 1
    val 
  end

  # O(1) ammortized
  def unshift(val)
    @start_idx -= 1
    @length += 1
    @store[@start_idx % @capacity] = val
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

4.times do |i|
  arr.push(i)
  p arr[i]
  arr.unshift(i)
end

