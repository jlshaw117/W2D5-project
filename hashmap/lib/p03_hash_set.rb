require_relative 'p02_hashing.rb'

class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    if @count == @store.length
      resize!
    end
    @store[key.hash % num_buckets] << key 
    @count += 1
  end

  def include?(key)
    hash = key.hash
    @store[hash % num_buckets].each do |el|
      return true if el == key
    end
    return false
  end

  def remove(key)
    @count -= 1 unless @store[key.hash % num_buckets].delete(key).nil?
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
        new_store[el.hash % new_store.length] << el
      end
    end
    @store = new_store
  end
end
