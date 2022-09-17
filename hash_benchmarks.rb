require 'benchmark'
TEST_ITERATIONS = 1_000_000

collections = []

collections << (1..100).to_a
collections << (1..1000).to_a
collections << (1..10000).to_a

collections << Hash[(1..100).to_a.zip([true] * 100)]
collections << Hash[(1..1000).to_a.zip([true] * 1000)]
collections << Hash[(1..10000).to_a.zip([true] * 10000)]

search_value = -1

Benchmark.bm do |test|
  collections.each do |col|

    test.report("#{col.size}-item #{col.class}") do

      TEST_ITERATIONS.times do
        if col.kind_of?(Array)
          col.include?(search_value)
        else
          col[search_value]
        end
      end

    end

  end
end
