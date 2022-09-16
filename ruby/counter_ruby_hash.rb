require 'stringio'

class FrequencyCounter
  attr_reader :pairs, :wordsCount, :distinctCount, :allWordsCount

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
    pairs[max] = 0
    pairs.each_key do |word|
      if pairs[word] > pairs[max]
        max = word
      end
    end
    [max, pairs[max]]
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
            if pairs.has_key?(word)
              pairs.store(word, pairs[word] + 1)
            else
              pairs.store(word, 1)
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

  counter = FrequencyCounter.new(Hash.new, 'leipzig1M.txt', 10)

  puts "Words Number: #{counter.wordsCount}"
  puts "Distinct words: #{counter.distinctCount}"
  max = counter.maxFrequencyWord
  puts "Max: #{max[0]} -> #{max[1]}"
  # puts "Words Number: #{counter.allWordsCount}"

  finish = Time.now

  diff = finish - start
  puts diff
end
# Words Number: 21191455
# 4.574042047

# Words Number: 1610829
# Distinct words: 165555
# Max: government -> 24763
# 6.905907642

# Words Number: 1610829
# Distinct words: 165555
# Max: government -> 24763
# 6.982421888
