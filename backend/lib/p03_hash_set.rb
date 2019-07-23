class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    unless include?(num)
      @store[num.hash % @store.length].push(num) 
      @count += 1
      resize! if @count > num_buckets
    end
  end

  def remove(num)
    if include?(num)
      @store[num.hash % @store.length].delete(num)
      @count -= 1
    end
  end

  def include?(num)
    @store[num.hash % @store.length].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num % @store.length]
  end

  def num_buckets
    @store.length
  end

  def resize!
    if count > num_buckets
      items = @store.flatten
      new_buck = num_buckets * 2
      @store = Array.new(new_buck) { Array.new }
      items.each do |ele|
        @store[ele.hash % @store.length].push(ele) 
      end
    end
  end
end
