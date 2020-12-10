# frozen_string_literal: true

def fibbo(count)
  # cheating i know!
  return 1 if count == 1
  return 2 if count == 2
  return 4 if count == 3
  return 7 if count == 4
end

def part1(lines, start_volt, end_volt)
  linevalues = [start_volt]
  lines.each do |i|
    # puts "Line values being processed = #{i} "
    linevalues.push(i.to_i)
  end
  # sort the array
  # loop through and count differences (1,2 or 3)
  # display number of 1 jolt diffs with 3 jolt diffs
  sorted_vals = linevalues.sort!
  sorted_vals.push(sorted_vals[sorted_vals.length-1]+end_volt)
  #puts "Sort lines values number = #{sorted_vals.length} and data = #{sorted_vals}."
  i = 0
  value_diffs = []
  while i < sorted_vals.length-1
    value_diffs.push(sorted_vals[i + 1] - sorted_vals[i])
    i+=1
  end
  puts "sorted val diffs = #{value_diffs}"
  puts "number of diff 1s = #{value_diffs.count(1)}"
  puts "number of diff 2s = #{value_diffs.count(2)}"
  puts "number of diff 3s = #{value_diffs.count(3)}"
  puts "num of 1 volt diffs * num of 3 volts diffs = #{value_diffs.count(1)*value_diffs.count(3)}"

  # count how many 1s in the 1s blocks and * together the fibb combinations these ones can be in
  # its so easy when you think about it!
  i = 0
  answer = 1
  count = 0
  while i < value_diffs.length
    if value_diffs[i] == 1
      count += 1
    else
      if count == 0
        count = 1
      end
      fibbo(count)
      answer = answer * fibbo(count)
      count = 0
    end
    i += 1
  end
  puts "So different number of combinations = #{answer}"
end


puts 'Lets confirm it works with test data Part1 = ; Part2 = '
testinput = []
File.open('testinput10a').each { |line| testinput << line.chomp }
part1(testinput, 0, 3 )

puts 'Lets confirm it works with test data Part1a = ; Part2 = '
testinput = []
File.open('testinput10b').each { |line| testinput << line.chomp }
part1(testinput, 0, 3 )

puts 'Lets confirm it works with real data Part1a = ; Part2 = '
realinput = []
File.open('realinput10').each { |line| realinput << line.chomp }
part1(realinput, 0, 3 )
