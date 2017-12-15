class DynamicArray
  include Enumerable
  attr_reader :length

  def initialize(el = nil)
    @store = StaticArray.new(1)
    @store[0] = el
    @length = 1
  end

  def push(el)
    @length += 1
    new_store = @store
    @store = StaticArray.new(@length)
    (@length - 1).times { |idx| @store[idx - 1] = new_store[idx] }
    @store[@length - 1] = el
  end

  def unshift(el)
    @length += 1
    new_store = @store
    @store = StaticArray.new(@length)
    @store[0] = el
    (@length - 1).times { |idx| @store[idx] = new_store[idx] }
  end

  def pop
    @length -= 1
    new_store = @store
    @store = StaticArray.new(@length)
    @length.times { |idx| @store[idx - 1] = new_store[idx] }
    new_store[@length]
  end

  def shift
    @length -= 1
    new_store = @store
    @store = StaticArray.new(@length)
    @length.times { |idx| @store[idx] = new_store[idx] }
    new_store[0]
  end

  def each(&prc)
    idx = 0
    while idx < @length
      prc.call(self[idx])
      idx += 1
    end
  end
end

class StaticArray
  def initialize(num_objects)
    @store = Array.new(num_objects)
  end

  def [](idx)
    @store[idx]
  end

  def []=(idx, val)
    @store[idx] = val
  end
end
