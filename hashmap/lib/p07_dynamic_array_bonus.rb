class StaticArray
  attr_reader :store

  def initialize(capacity)
    @store = Array.new(capacity)
  end

  def [](i)
    validate!(i)
    self.store[i]
  end

  def []=(i, val)
    validate!(i)
    self.store[i] = val
  end

  def length
    self.store.length
  end

  private

  def validate!(i)
    raise "Overflow error" unless i.between?(0, self.store.length - 1)
  end
end

class DynamicArray
  include Enumerable
  attr_accessor :count

  def initialize(capacity = 8)
    @store = StaticArray.new(capacity)
    @count = 0
  end

  def [](i)
    i = @count + i if i < 0
    return nil if i < 0
    return nil if i >= @count
    @store[i]
  end

  def []=(i, val)
    @store[i] = val 
  end

  def capacity
    @store.length
  end

  def include?(val)
    self.each do |el|
      return true if el == val 
    end
    false
  end

  def push(val)
    resize! if @store.length == @count 
    @store[@count] = val
    @count += 1 
  end

  def unshift(val)
    resize! if @store.length == @count 
    
    i = @count
    while i > 0
      @store[i] = @store[i-1]
      i -= 1
    end
    @store[0] = val
    @count += 1
  end

  def pop
    return nil if @count == 0
    res = @store[@count - 1]
    @store[@count - 1] = nil
    @count -= 1 
    res
  end

  def shift
    return nil if count == 0
    res = @store[0]
    i = 1
    while i < @count
      @store[i - 1] = @store[i] 
      i += 1
    end
    @count -= 1
    @store[@count] = nil
    res
  end

  def first
    @store[0]
  end

  def last
    @store[@count - 1]
  end

  def each(&prc)
    i = 0
    while i < @count
      prc.call(@store[i])
      i += 1
    end
  end

  def to_s
    "[" + inject([]) { |acc, el| acc << el }.join(", ") + "]"
  end

  def ==(other)
    return false unless [Array, DynamicArray].include?(other.class)
    return false if @count != other.length
    (0...@count).each do |i|
      return false unless self[i] == other[i]
    end
    return true
  end

  alias_method :<<, :push
  [:length, :size].each { |method| alias_method method, :count }

  private

  def resize!
    new_array = StaticArray.new(@store.length * 2)
    self.each_with_index do |el, i|
      new_array[i] = el
    end
    @store = new_array
  end
end
