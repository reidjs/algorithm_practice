# Implement a queue with #enqueue and #dequeue, as well as a #max API,
# a method which returns the maximum element still in the queue. This
# is trivial to do by spending O(n) time upon dequeuing.
# Can you do it in O(1) amortized? Maybe use an auxiliary storage structure?

# Use your RingBuffer to achieve optimal shifts! Write any additional
# methods you need.

require_relative 'ring_buffer'

class QueueWithMax
  attr_accessor :store

  def initialize
    @length = 0
    @store = RingBuffer.new
  end

  def enqueue(val)
    @length += 1
    @store.push(val)
  end

  def dequeue
    @length -= 1
    @store.shift
  end

  def max
    i = 0
    @max = nil
    while i < @length 
      @max = @store[i] if @max.nil? || @store[i] > @max
      i += 1
    end 
    @max
  end

  def length
    @length
  end

end
