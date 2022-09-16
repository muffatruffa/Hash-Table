require './sequential'

class HashTable
  def initialize(buckets = 197)
    @chains = []
    @size = 0
    fillChains(buckets)
  end

  def set(key, value)
    index = hash(key)
    @chains[index].set(key, value)
    @size += 1
    return value
  end

  def get(key)
    index = hash(key)
    return @chains[index].get(key)
  end

  def has(key)
    index = hash(key)
    return @chains[index].has(key)
  end

  def keys(&block)
    index = 0
    while index < @chains.length
      @chains[index].keys(&block)
      index += 1
    end
  end

private

  def fillChains(buckets)
    index = 0
    while index < buckets
      @chains[index] = SequentialSearch.new
      index += 1
    end
  end

  def hash(key)
    m = @chains.length
    hash = 0
    char_index = 0
    len = key.length
    while char_index < len
      hash = (31 * hash + key[char_index].ord) % m
      char_index += 1
    end
    return hash
  end

  # def hash(key)
  #   hash = 0
  #   char_index = 0
  #   len = key.length
  #   while char_index < len
  #     hash += key[char_index].ord
  #     char_index += 1
  #   end
  #   return hash % @chains.length
  # end
end