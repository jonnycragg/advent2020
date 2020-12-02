# frozen_string_literal: true

def part1(lines, check)
  lines.each do |i|
    lines.each do |j|
      next unless i + j == check

      puts "Found it! i=#{i}, j=#{j}; i*j=#{i * j}"
      break
    end
  end
end

def part2(lines, check)
  lines.each do |i|
    lines.each do |j|
      lines.each do |k|
        next unless i + j + k == check

        puts "Found it! i=#{i}, j=#{j}, k=#{k}; i*j*k=#{i * j * k}"
        break
      end
    end
  end
end

def sum_2_to_n?(arr, n)
  return true if arr.empty? && n.zero?
  arr.combination(2).any? {|a, b| a + b == n }
end

def sum_3_to_n?(arr, n)
  return true if arr.empty? && n.zero?
  arr.combination(3).any? {|a, b, c| a + b + c == n }
end

puts 'Lets confirm it works with test data Part1=514579; Part2=241861950'
testinput = []
File.open('testinputday1').each { |line| testinput << line.to_i }
part1(testinput, 2020)
part2(testinput, 2020)
puts sum_2_to_n?(testinput, 2020)
puts sum_3_to_n?(testinput, 2020)

puts 'Lets now use the real data'
realinput = []
File.open('inputday1').each { |line| realinput << line.to_i }
part1(realinput, 2020)
part2(realinput, 2020)
