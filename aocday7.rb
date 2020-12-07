def part1(lines)
  answered_y = []
  group_answered_y = []
  lines.each do |i|
    puts "Line values being processed = #{i} "
    linevalues = i.split("contain")
    linevalues[1] = linevalues[1].split(",")
    colour = linevalues[0].split(" ")
    key = colour[1]
    linevalues[0] = key
    i = 0
    linevalues[1].each do |j|
      node = j.split(" ")
      linevalues[1][i] = node[2]
      i =+ 1
    end
    puts "Line values being processed = #{linevalues} and colour key = #{key}"
    #if linevalues.empty?
    #  group_answered_y.push(answered_y.dup)
    #  answered_y = []
    #else
    #  puts "Line values being processed = #{linevalues}"
    #  answered_y.push(linevalues)
    #end
  end
end

puts 'Lets confirm it works with test data Part1 = x valid; Part2 = '
testinput = []
File.open('testinput7').each { |line| testinput << line.chomp }
part1(testinput)

#puts 'Lets now use the real data'
#realinput = []
#File.open('inputday7').each { |line| realinput << line.chomp }
#part1(realinput)

