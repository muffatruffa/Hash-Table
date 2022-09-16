class SequentialSearch
  def initialize()
    @pairs = []
  end

  def set(key,value)
    len = @pairs.length
    index = 0
    while index < len
      pair = @pairs[index]
      if pair[0] == key
        pair[1] = value
        return value
      end
      index += 1
    end
    @pairs.push([key, value])
    return value
  end

  def get(key)
    len = @pairs.length
    index = 0
    while index < len
      pair = @pairs[index]
      if pair[0] == key
        return pair[1]
      end
      index += 1
    end
    nil
  end

  def has(key)
    !get(key).nil?
  end

  def keys()
    len = @pairs.length
    index = 0
    while index < len
      pair = @pairs[index]
      yield pair[0]
      index += 1
    end
  end

end
