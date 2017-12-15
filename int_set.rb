# def initialize
#
# end
#
# def insert(el)
#
# end
#
# def remove(el)
#
# end
#
# def include?(el)
#
# end

class MaxIntSet
  attr_reader :store
  def initialize(max)
    @store = Array.new(max)
    @store.map! { |el| el = false }
  end

  def insert(el)
    raise "out of bounds" if el < 0 || el > @store.length
    @store[el] = true
  end

  def remove(el)
    raise "out of bounds" if el < 0 || el > @store.length
    @store[el] = false
  end

  def include?(el)
    @store[el]
  end
end

class IntSet
  def initialize
    @store = Array.new(20) { [] }
  end

  def insert(el)
    return false if include?(num)
    @store[el % 20] << el
  end

  def remove(el)
    @store[el % 20].delete(el)
  end

  def include?(el)
    @store[el % 20].include?(el)
  end
end

class ResizingIntSet
  attr_reader :buckets
  def initialize()
    @store = Array.new(20) { [] }
    @num_buckets = 20
    @num_elements = 0
    @multiplier = 20
  end

  def insert(el)
    return false if include?(el)
    self[el] << el
    @num_elements += 1
    resize if @num_elements == @num_buckets
  end

  def remove(el)
    self[el].delete(el)
    @num_elements -= 1
  end

  def include?(el)
    self[el].include?(el)
  end

  def resize
    @num_buckets *= @multiplier
    new_store = @store
    @store = Array.new(@num_buckets) { [] }
    new_store.flatten.each { |el| insert(el) }
  end

  def [](num)
    @store[num % @num_buckets]
  end
end
