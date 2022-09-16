require 'stringio'
require './sequential'
require './binary'
require './hash_table'

class FrequencyCounter
  attr_reader :pairs, :wordsCount, :distinctCount

  def initialize(pairs_data_type, file_name, min_len = 1)
    @pairs = pairs_data_type
    @file_name = file_name
    @length_threshold = min_len
    @wordsCount = 0
    @distinctCount = 0
    loadWords()
  end

  def maxFrequencyWord()
    max = ''
    pairs.set(max, 0)
    pairs.keys() do |word|
      if pairs.get(word) > pairs.get(max)
        max = word
      end
    end
    [max, pairs.get(max)]
  end

  private

  def loadWords()
    emulateIO = StringIO.new
    File.open(@file_name) do |file|
      file.each("\n", chomp: true) do |line|

        emulateIO.string = line
        emulateIO.each(' ', chomp: true) do |word|
          if word.size >= @length_threshold
            @wordsCount += 1
            if pairs.has(word)
              pairs.set(word, pairs.get(word) + 1)
            else
              pairs.set(word, 1)
              @distinctCount += 1
            end
          end
        end

      end
    end

    emulateIO.close
    emulateIO = nil
  end
end

if __FILE__ == $PROGRAM_NAME
  start = Time.now
  # counter = FrequencyCounter.new(SequentialSearch.new, 'leipzig1M.txt', 10)
  counter = FrequencyCounter.new(BinarySearch.new, 'leipzig1M.txt', 10)
  # counter = FrequencyCounter.new(HashTable.new(250007), 'leipzig1M.txt', 10)
  # counter = FrequencyCounter.new(HashTable.new(41399), 'leipzig1M.txt', 10)
  # counter = FrequencyCounter.new(HashTable.new(165559), 'leipzig1M.txt', 10)


  puts "Words Number: #{counter.wordsCount}"
  puts "Distinct words: #{counter.distinctCount}"
  max = counter.maxFrequencyWord
  puts "Max: #{max[0]} -> #{max[1]}"

  finish = Time.now

  diff = finish - start
  puts diff
end
# counter = FrequencyCounter.new(HashTable.new(116507), 'leipzig1M.txt', 10)
# Words Number: 1610829
# Distinct words: 165555
# Max: government -> 24763
# 26.055250964

# counter = FrequencyCounter.new(HashTable.new(41399), 'leipzig1M.txt', 10) load factor = 1/4 
# Words Number: 1610829
# Distinct words: 165555
# Max: government -> 24763
# 26.536110905

# counter = FrequencyCounter.new(HashTable.new(41399), 'leipzig1M.txt', 10) load factor = 1/4 
# A better hash function
# Words Number: 1610829
# Distinct words: 165555
# Max: government -> 24763
# 15.834152241

# Words Number: 1610829
# Distinct words: 165555
# Max: government -> 24763
# 15.65567382

# counter = FrequencyCounter.new(BinarySearch.new, 'leipzig1M.txt', 10)
# Words Number: 1610829
# Distinct words: 165555
# Max: government -> 24763
# 826.045768086

# counter = FrequencyCounter.new(SequentialSearch.new, 'leipzig1M.txt', 10)
# Words Number: 1610829
# Distinct words: 165555
# Max: government -> 24763
# 6681.518073575 -> 1 hour 51 minutes, I felt asleep

