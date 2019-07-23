class Integer
  # Integer#hash already implemented for you
end

class Array
  def hash
    self.map{ |ele| (ele ^ length).to_s(2) }.join("").to_i
  end
end

class String
  def hash
    alphabet = ("a".."z").to_a
    self.split("").map{ |ele| (alphabet.index(ele) ^ length).to_s }.join("").to_i
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    (keys.sort.map(&:to_s) + values.sort).join("").hash
  end
end
