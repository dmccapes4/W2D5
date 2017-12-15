require 'byebug'

class LRUCache
    def initialize(el)
      @list = LinkedList.new(Node.new(el))
    end

    def count
      @list.length
    end

    def add(el)
      if @list.find(el)
        move_to_front(el)
      else
        @list.prepend(el)
      end
      @list.pop if count > 4
    end

    def show
      @list.display
    end

    private
    def move_to_front(el)
      node = @list.find(el)
      if node
        node.prev_node.next_node = node.next_node
        node.next_node.prev_node = node.prev_node
        @list.start_node.prev_node = node
        node.next_node = @list.start_node
        node.prev_node = nil
        @list.start_node = node
      end
    end

  end

  class LinkedList
    attr_accessor :start_node, :end_node

    def initialize(node = nil)
      @hash = {}
      @start_node = node
      @end_node = node
      @length = node.nil? ? 0 : 1
    end

    def append(el)
      node = Node.new(el)
      @end_node.next_node = node
      node.next_node = nil
      node.prev_node = @end_node
      @end_node = node
      @hash[el] = node
      @length += 1
    end

    def prepend(el)
      node = Node.new(el)
      @start_node.prev_node = node
      node.next_node = @start_node
      node.prev_node = nil
      @start_node = node
      @hash[el] = node
      @length += 1
    end

    def find(el)
      return false unless @hash[el]
      @hash[el]
    end

    def length
      @length
    end

    def pop
      @end_node = @end_node.prev_node
      @end_node.next_node = nil
      @hash[@end_node.el] = nil
      @length -= 1
    end

    def display
      out = []
      node = @start_node
      until node.nil?
        out << node.el
        node = node.next_node
      end
      print out.reverse
    end
  end

  class Node
    attr_accessor :el, :next_node, :prev_node

    def initialize(el)
      @el = el
      @next_node = next_node
    end

    def to_s
      @el
    end
  end


  johnny_cache = LRUCache.new(4)

  johnny_cache.add("I walk the line")
  johnny_cache.add(5)

  johnny_cache.count # => returns 2

  johnny_cache.add([1,2,3])
  johnny_cache.add(5)
  johnny_cache.add(-5)
  johnny_cache.add({a: 1, b: 2, c: 3})
  johnny_cache.add([1,2,3,4])
  johnny_cache.add("I walk the line")
  johnny_cache.add(:ring_of_fire)
  johnny_cache.add("I walk the line")
  johnny_cache.add({a: 1, b: 2, c: 3})


  johnny_cache.show # => prints [[1, 2, 3, 4], :ring_of_fire, "I walk the line", {:a=>1, :b=>2, :c=>3}]
