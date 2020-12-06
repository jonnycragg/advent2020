def part1(lines)
  answered_y = []
  group_answered_y = []
  lines.each do |i|
    linevalues = i.chars
    # puts "Line values being processed = #{linevalues}"
    if linevalues.empty?
      group_answered_y.append(answered_y.dup)
      answered_y = []
    else
      answered_y.append(linevalues)
    end
  end

  # Part 1
  puts ">>>> Part 1 Group answered y = #{group_answered_y.length}"
  total_unique_y = 0
  group_answered_y.each do |count_union|
    #puts "Does this really work, how awesome! = #{count_union.inject(:|)}"
    total_unique_y += count_union.inject(:|).length
  end
  #puts "Answer = #{total_unique_y}"
  sum_group_counts =+ total_unique_y
  puts ">>>> Part 1: Total union of all answers = #{sum_group_counts}"

  # Part 2
  puts ">>> Part2 Group answered y = #{group_answered_y.length}"
  total_unique_y = 0
  group_answered_y.each do |count_inter|
    #puts "Does this really work, how awesome! = #{count_inter.inject(:&)}"
    total_unique_y += count_inter.inject(:&).length
  end
  #puts "Answer = #{total_unique_y}"
  sum_group_counts =+ total_unique_y
  puts "Part 2: Total of all answers = #{sum_group_counts}"
end

puts 'Lets confirm it works with test data Part1 = 11 valid; Part2 = 6'
testinput = []
File.open('testinput6').each { |line| testinput << line.chomp }
part1(testinput)

puts 'Lets now use the real data'
realinput = []
File.open('inputday6').each { |line| realinput << line.chomp }
part1(realinput)
