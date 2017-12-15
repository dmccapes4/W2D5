class Array
  def hash
    each_with_index.reduce(0) do |acc, (el, idx)|
      (el.hash + idx.hash) ^ acc
    end
  end
end

class String
  def hash
    chars.map(&:ord).hash
  end
end

class Hash
  def hash
    to_a.sort_by(&:hash).hash
  end
end
