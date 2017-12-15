class LinkedList
  include Enumerable

  attr_reader :length

  def initialize(node = nil)
    @start_node = node
    @length = node.nil? ? 0 : 1
  end

  def append(key, value)
    node = Node.new(key, value)
    if @start_node
      @start_node.prev_node = node
      node.next_node = @start_node
      node.prev_node = nil
    end
      @start_node = node
      @length += 1
  end

  def update(key, value)
    node = get(key)
    node.value = value
  end

  def get(key)
    self.each do |node|
      return node if node.key == key
    end
    false
  end

  def remove(key)
    node = @start_node
    until node.nil?
      if node.key == key
        @start_node = nil if node == @start_node
        node.prev_node.next_node = node.next_node unless node.prev_node.nil?
        node.next_node.prev_node = node.prev_node unless node.next_node.nil?
        @length -= 1
        return node
      end
      node = node.next_node
    end
    false
  end

  def empty?
    @start_node.nil?
  end

  def pop
    @start_node = @end_node.next
    @start_node.prev_node = nil
  end

  def display
    out = self.reduce([]) { |acc, node| acc << [node.key, node.value] }
    print out
  end

  def each(&prc)
    node = @start_node
    until node.nil?
      prc.call(node)
      node = node.next_node
    end
  end
end

class Node
  attr_accessor :key, :value, :next_node, :prev_node

  def initialize(key, value)
    @key = key
    @value = value
  end

  def to_s
    @key
  end
end
