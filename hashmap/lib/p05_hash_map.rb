require_relative 'p04_linked_list'

class HashMap
  include Enumerable
  attr_accessor :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    @store[key.hash % @store.length].include?(key)
  end

  def set(key, val)
    resize! if @count == @store.length
    
    if !include?(key)
      @store[key.hash % @store.length].append(key, val)
      @count += 1
    else
      @store[key.hash % @store.length].update(key,val)
    end 
  end

  def get(key)
    @store[key.hash % @store.length].each do |node|
      return node.val if node.key == key
    end
  end

  def delete(key)
    @count -= 1 if !@store[key.hash % @store.length].remove(key).nil?
    
  end

  def each(&prc)
    @store.each do |link_list|
      link_list.each do |node|
        prc.call(node.key, node.val)
      end
    end
  end

  # uncomment when you have Enumerable included
  def to_s
    pairs = inject([]) do |strs, (k, v)|
      strs << "#{k.to_s} => #{v.to_s}"
    end
    "{\n" + pairs.join(",\n") + "\n}"
  end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    new_store = Array.new(@count * 2) { LinkedList.new }
    self.each do |k, v|
      new_store[k.hash % new_store.length].append(k, v)
    end
    @store = new_store
  end

  def bucket(key)
    # optional but useful; return the bucket corresponding to `key`
  end
end
