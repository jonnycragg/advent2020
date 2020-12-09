$rules = {}
$paths = []
$depth = 0
$picture = []
def find(node, result)
  if node == ''
    return result
  end
  #puts "processing node = #{node}"
  $rules[node].each do |n|
    #puts "recursion? #{n[1][0]}"
    result.append(n[1][0])
    #$paths.append(find(n))
    find(n[1][0],result)
  end
end

def find2(node, result)
  if node == ''
    return result
  end
  puts "Depth = #{$depth+=1}"
  #puts "processing node = #{node}"
  $picture.append(node)
  $rules[node].each do |n|
    $picture.append(n[1][0])
    puts "Whats n? #{n}"
    #puts "recursion? node = #{n[0]} bags #{n[1][0]}"
    #result.append(n[0],n[1][0])
    result.append(n[0],"*")
    loop = n[0].to_i
    loop.times do
      find2(n[1][0],result)
    end
  end
  result.append("+")
  $depth-=1
  #puts "Do I ever get here? Depth = #{$depth}"
end

def part1(lines)
  #  rules = {}
  lines.each do |i|
    #puts "Line values being processed = #{i} "
    linevalues = i.split('contain')
    #puts "Line values = #{linevalues} "
    linevalues[1] = linevalues[1].split(',')
    #puts "Line values = #{linevalues} "
    colour = linevalues[0].split(' ')
    key = colour[0] + colour[1]
    linevalues[0] = key
    #puts "Line values = #{linevalues} "
    i = 0
    linevalues[1].each do |j|
      node = j.split(' ')
      linevalues[1][i] = if node[2].eql?('bags.')
                           ['',['']]
                         else
                           [node[0], [node[1] + node[2]]]
                         end
      i += 1
      #puts "Line values = #{linevalues} "
    end
    #puts "Line values being processed = #{linevalues}."
    $rules[key] = linevalues[1]
  end
  puts "Rule set length is #{$rules.length} and = #{$rules}."

  # You have a shiny gold bag. If you wanted to carry it in at least one other bag, how many different bag colors would be valid for the outermost bag? (In other words: how many colors can, eventually, contain at least one shiny gold bag?)
  # In the above rules, the following options would be available to you:
  # --------------------------------------------------------------------
  # A bright white bag, which can hold your shiny gold bag directly.
  # A muted yellow bag, which can hold your shiny gold bag directly, plus some other bags.
  # A dark orange bag, which can hold bright white and muted yellow bags, either of which could then hold your shiny gold bag.
  # A light red bag, which can hold bright white and muted yellow bags, either of which could then hold your shiny gold bag.
  # So, in this example, the number of bag colors that can eventually contain at least one shiny gold bag is 4.

  find_bag = 'gold'
  count_possibilities = 0
  $rules.each do |i|
    result = []
    #puts "I am here #{i[0]}"
    find(i[0],result)
    #puts "Result set this rule check = #{result}"
    if result.any?("shinygold")
      count_possibilities += 1
      #puts "Found shinygold!"
    end
  end
  puts "Found gold possibilities #{count_possibilities}"
  #puts "ALl paths found = #{$paths}"
end

def part2(lines)
  part1(lines)
  result = []
  find2("shinygold", result)
  puts "part 2 #{result}"
  puts "picture = #{$picture}"
  #puts "Part 2 picture = #{result[0].to_i + result[0].to_i * result[2]+result[2]*result[4]+result[4]*result[6]+result[6]*result[8]+result[8]*result[10]}"
  puts 2+(2*2)+(2*2*2)+(2*2*2*2)+(2*2*2*2*2)+(2*2*2*2*2*2)
end

#puts 'Lets confirm it works with test data Part1 = x valid; Part2 = '
#testinput = []
#File.open('testinput7').each { |line| testinput << line.chomp }
#part1(testinput)

#puts 'Lets now use the real data'
#realinput = []
#File.open('inputday7').each { |line| realinput << line.chomp }
#part1(realinput)

puts 'Lets now use the test data for part2'
$rules = {}
$paths = []
$picture = []
testinputp2 = []
File.open('testinput7p2').each { |line| testinputp2 << line.chomp }
part2(testinputp2)
puts "Picture length = #{$picture.length}"


puts 'Lets now use the other test data for part2'
$rules = {}
$paths = []
$picture = []
testinputp3 = []
File.open('testinput7a').each { |line| testinputp3 << line.chomp }
part2(testinputp3)
puts "Picture length = #{$picture.length}"
