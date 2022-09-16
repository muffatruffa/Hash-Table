class BinarySearch
  def initialize()
    @orderedkeys = []
    @values = []
    @size = 0
  end

  def set(key, value)
    index = rank(key)
    # update the value for the given key
    if index < @size && @orderedkeys[index] == key
        @values[index] = value
        return value
    end

    # insert new key value pairs
    startShifting = @size
    while startShifting > index
      @orderedkeys[startShifting] = @orderedkeys[startShifting - 1]
      @values[startShifting] = @values[startShifting - 1]
      startShifting -= 1
    end

    @orderedkeys[index] = key
    @values[index] = value
    @size += 1
    return value
  end

  def get(key)
    index = rank(key)
    if index < @size && @orderedkeys[index] == key
      return @values[index]
    end
    return nil # nil is not allowed as a value
  end

  def keys(&block)
    @orderedkeys.each(&block)
  end

  def has(key)
    return !get(key).nil? # nil is not a valid value
  end


  private

  def rank(key)
    lo = 0
    hi = @size - 1
    while (lo <= hi)
      mid = lo + (hi - lo).div(2)
      if(key < @orderedkeys[mid])
        hi = mid - 1
      elsif (key > @orderedkeys[mid])
        lo = mid + 1
      else
        return mid
      end
    end
    return lo
  end
end