# frozen_string_literal: true

def part1(lines)
  numValid = 0
  lines.each do |input|
    a = input.split(/\W+/)
    min = a[0].to_i
    max = a[1].to_i
    char = a[2]
    pwd = a[3]
    numValid += 1 if pwd.count(char) >= min && pwd.count(char) <= max
  end
  puts "So number valid pwds = #{numValid}"
end

def part2(lines)
  numValid = 0
  lines.each do |input|
    a = input.split(/\W+/)
    pos1 = a[0].to_i
    pos2 = a[1].to_i
    char = a[2]
    pwd = a[3]
    # Exactly one of these positions must contain the given letter
    numValid += 1 if pwd[pos1 - 1].eql?(char) ^ pwd[pos2 - 1].eql?(char)
  end
  puts "So number valid pwds = #{numValid}"
end

puts 'Lets confirm it works with test data Part1 = 2; Part2 = 1'
testinput = []
File.open('testinputday2').each { |line| testinput << line }
part1(testinput)
part2(testinput)

puts 'Lets now use the real data'
realinput = []
File.open('inputday2').each { |line| realinput << line }
part1(realinput)
part2(realinput)
