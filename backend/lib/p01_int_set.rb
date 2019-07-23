class MaxIntSet
  
  attr_reader :store

  def initialize(max)
    @store = Array.new(max + 1, false)
  end

  def insert(num)
    raise "Out of bounds" unless is_valid?(num)
    @store[num] = true
  end

  def remove(num)
    @store[num] = false
  end

  def include?(num)
    @store[num]
  end

  private

  def is_valid?(num)
    num < @store.length && num > 0
  end

  def validate!(num)
    @store += Array.new((num + 1) - @store.length, false)
    @store[num] = true
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    @store[num % @store.length].push(num)
  end

  def remove(num)
    @store[num % @store.length].delete(num)
  end

  def include?(num)
    @store[num % @store.length].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num % @store.length]
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count, :store

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    unless include?(num)
      @store[num % @store.length].push(num) 
      @count += 1
      resize! if @count > num_buckets
    end
  end

  def remove(num)
    if include?(num)
      @store[num % @store.length].delete(num)
      @count -= 1
    end
  end

  def include?(num)
    @store[num % @store.length].include?(num)
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
        @store[ele % @store.length].push(ele) 
      end
    end
  end

end
