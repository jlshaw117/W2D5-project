class MaxIntSet
  def initialize(max)
    @store = Array.new(max, false)
  end

  def insert(num)
    @store[num] = true if is_valid?(num)    
  end

  def remove(num)
    @store[num] = false if is_valid?(num)
  end

  def include?(num)
    @store[num]
  end

  private

  def is_valid?(num)
    raise "Out of bounds" if num >= @store.length || num < 0
    true
  end

  def validate!(num)
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    @store[num % @store.length] << num unless include?(num)
  end

  def remove(num)
    @store[num % @store.length].delete(num)
  end

  def include?(num)
    @store[num % @store.length].each do |el|
      return true if el == num
    end
    false
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    resize! if @count == @store.length
    
    unless include?(num)
      @store[num % @store.length] << num 
      @count += 1
    end
  end

  def remove(num)
    @count -= 1 unless @store[num % @store.length].delete(num).nil?
  end

  def include?(num)
    @store[num % @store.length].each do |el|
      return true if el == num
    end
    false
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end

  def resize!
    new_store = Array.new(@count * 2) { Array.new }
    @store.each do |bucket|
      bucket.each do |el|
        new_store[el % new_store.length] << el
      end
    end
    @store = new_store
  end
end
