require_relative 'linked_list'

class HashSet
  attr_reader :buckets
  def initialize()
    @store = Array.new(20) { LinkedList.new }
    @num_buckets = 20
    @num_elements = 0
    @multiplier = 20
  end

  def insert(key, value)
    update(key, value) if include?(key)
    self[key].append(key, value)
    @num_elements += 1
    resize if @num_elements == @num_buckets
  end

  def update(key, value)
    self[key].get(key).value = value
  end

  def remove(key)
    self[key].remove(key)
    @num_elements -= 1
  end

  def include?(key)
    self[key].get(key)
  end

  def resize
    @num_buckets *= @multiplier
    new_store = @store
    @store = Array.new(@num_buckets) { LinkedList.new }
    new_store.each do |bucket|
      bucket.each { |node| @store.insert(node.key, node.value) }
    end
  end

  def [](num)
    @store[num.hash % @num_buckets]
  end
end
