class Node
  attr_reader :key
  attr_accessor :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    # optional but useful, connects previous link to next link
    # and removes self from list.
  end
end

class LinkedList
  include Enumerable

  def initialize
    @head = Node.new
    @tail = Node.new

    @head.next = @tail
    @tail.prev = @head
    
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @head.next
  end

  def last
    @tail.prev
  end

  def empty?
    return true if @head.next == @tail
    false
  end

  def get(key)
    self.each do |node|
      if node.key == key
        return node.val
      end
    end
    nil
  end

  def include?(key)
    self.each do |node|
      if node.key == key
        return true
      end
    end
    false
  end

  def append(key, val)
    new_node = Node.new(key, val)
    prev_node = @tail.prev
    @tail.prev = new_node
    new_node.next = @tail
    new_node.prev = prev_node
    prev_node.next = new_node
  end

  def update(key, val)
    self.each do |node|
      if node.key == key
        node.val = val
        return true
      end
    end
    false
  end

  def remove(key)

    self.each do |node|
      if node.key == key
        prev_node = node.prev
        next_node = node.next
        next_node.prev = prev_node
        prev_node.next = next_node
        return true
      end
    end

    false
  end

  def each(&prc)
    current_node = @head.next
    until current_node == @tail
      prc.call(current_node)
      current_node = current_node.next
    end
  end

  # uncomment when you have `each` working and `Enumerable` included
  # def to_s
  #   inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  # end
end
