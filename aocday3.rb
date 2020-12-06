def part1(lines,iInc,jInc)
  tree = '#'
  countTrees = 0
  i = 0
  j = 0
  path = []
  maxI = lines[0].length

  while j < lines.length-1
    i += iInc
    if i >= maxI
      i -= maxI
    end
    j += jInc
    if lines[j][i].nil?
      puts "NIL Path for #{i}, #{j} = #{lines[j][i]}"
    end
    path << lines[j][i]
    countTrees += 1 if lines[j][i] == tree
  end
  puts "So number of trees = #{countTrees}"
  puts "Path looks like this = #{path}"
end

puts 'Lets confirm it works with MY simple data'
testinput = []
File.open('testinput3a').each { |line| testinput << line.chomp }
part1(testinput,2,1)

puts 'Lets confirm it works with test data Part1 = 7; Part2 = 2,7,3,4,2'
testinput = []
File.open('testinput3').each { |line| testinput << line.chomp }
part1(testinput,1,1)
part1(testinput,3,1)
part1(testinput,5,1)
part1(testinput,7,1)
part1(testinput,1,2)
puts 2*7*3*4*2

puts 'Lets now use the real data'
realinput = []
File.open('inputday3').each { |line| realinput << line.chomp }
part1(realinput,1,1)
part1(realinput,3,1)
part1(realinput,5,1)
part1(realinput,7,1)
part1(realinput,1,2)
puts 66*153*79*92*33
