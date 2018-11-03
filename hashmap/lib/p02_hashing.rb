class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    total = 0
    self.each_with_index do |el, i|
      total += el.hash * (i + 1)
    end
    return total 
  end
end

class String
  def hash
    total = 0
    self.each_char.with_index do |c, i|
      total += c.ord * (i + 1)
    end
    return total
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    total = 0
    self.each do |k, v|
      total += k.hash * v.hash
    end
    return total
  end
end
