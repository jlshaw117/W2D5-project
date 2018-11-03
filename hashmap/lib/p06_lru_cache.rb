require "byebug"
require_relative 'p05_hash_map'
require_relative 'p04_linked_list'

class LRUCache
  attr_reader :store
  
  def initialize(max, prc)
    @map = HashMap.new
    @store = LinkedList.new
    @max = max
    @prc = prc
  end

  def count
    @map.count
  end

  def get(key)
    node = @store.remove(key)
    value = node.nil? ? @prc.call(key) : node.val
    @map[key] = @store.append(key, value)
    eject! if @store.count > @max
    
    return value
  end

  def to_s
    'Map: ' + @map.to_s + '\n' + 'Store: ' + @store.to_s
  end

  private

  def calc!(key)
    # suggested helper method; insert an (un-cached) key
  end

  def update_node!(node)
    # suggested helper method; move a node to the end of the list
    
  end

  def eject!
    @store.remove(@store.first.key)
  end
end

# 
# prc = Proc.new { |i| i ** 2 }
# cache = LRUCache.new(3, prc)
# i = 0
# while i < 5
#   cache.get(i)
#   p cache.store.to_s
#   i += 1
# end
# 
# cache.get(3)
# p cache.store.to_s
