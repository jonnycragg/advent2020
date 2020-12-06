require "benchmark"

def bruteforcing(arr)
  arr.combination(2).find_all{ |x, y| x + y == 2020 }.uniq
end

def search(arr)
  ret=[]
  arr.sort!

  while arr != []
    current = arr.pop
    arr.each.with_index do |value, index|
      if current + value == 2020
        ret << [value,current]
        arr.delete_at(index)
        break
      elsif current+value > 2020
        break
      end
    end
  end
  ret
end

def bench_times(n)
  Benchmark.bm do |x|
    puts "bench n times #{n}."
    inputArray = []
    File.open('testinputday1').each { |line| inputArray << line.to_i }
    x.report { n.times{bruteforcing(inputArray) }  }
    inputArray = []
    File.open('testinputday1').each { |line| inputArray << line.to_i }
    x.report { n.times{ search(inputArray) } }
  end
end

def bench_elements(n)
  puts "bench with #{n} elements."
  Benchmark.bm do |x|
    a=[]
    1_000.times { a<<rand(1..4) }
    x.report { bruteforcing(a) }
    a=[]
    1_000.times { a << rand(1..4) }
    x.report { search(a) }
  end
end

puts 'Lets now use the test data'
testinput = []
File.open('testinputday1').each { |line| testinput << line.to_i }
puts bruteforcing(testinput).to_s
testinput = []
File.open('testinputday1').each { |line| testinput << line.to_i }
puts search(testinput).to_s

puts 'Lets now use the real data'
realinput = []
File.open('inputday1').each { |line| realinput << line.to_i }
puts bruteforcing(realinput).to_s
puts search(realinput).to_s

puts 'Lets run bench multiple times'
File.open('testinputday1').each { |line| testinput << line.to_i }
bench_times 1,testinput
bench_times 5,testinput
bench_times 1_000,testinput
bench_times 1_000_000,testinput

# bench_elements(100)
# bench_elements(1_000)
# bench_elements(100_000)
# bench_elements(1_000_000)
