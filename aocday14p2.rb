def pad(num)
  paddedNum = "000000000000000000000000000000000000"
  return paddedNum[0..paddedNum.length - num.length-1] + num
end

def updateMem(newNum,mask,oldNum)
  puts "new Num = #{newNum}"
  puts "   mask = #{mask}"
  puts "old num = #{oldNum}"
  pointer = 0
  while pointer < newNum.length
    if mask[pointer] == 'X'
      oldNum[pointer] = newNum[pointer]
    else
      oldNum[pointer] = mask[pointer]
    end
    pointer += 1
  end
  return oldNum
end

def part1(lines)
  puts "input = #{lines}"
  mask = []
  memory = {}
  lines.each do |line|
    if line[0..2] == "mas"
      mask = line[7..line.length]
      next
    end
    if line[0..2] == "mem"
      lineparts = line.split(/]/)
      mem_key = lineparts[0][4..lineparts[0].length-1].to_i
      mem_num = pad(lineparts[1][3..lineparts[1].length-1].to_i.to_s(2))
      if !memory.key?(mem_key)
        memory[mem_key] = updateMem(mem_num,mask,"000000000000000000000000000000000000")
      else
        memory[mem_key] = updateMem(mem_num,mask,memory[mem_key])
      end
      #puts "mem lineparts = #{lineparts}"
      #puts "memory = #{memory}"
      next
    end
  end
  #puts "Mask = #{mask}"
  #puts "memory = #{memory}"
  # loop through memory and add up all non zero to integers
  total = 0
  memory.each do |name,value|
    #puts "is this key? #{name} and this value = #{value}"
    total += value.to_i(2)
  end
  puts "Total of mem locations = #{total}"
end

puts 'Lets confirm it works with test data Part1 = 165; Part2 = '
testinput = []
File.open('testinput14').each { |line| testinput << line.chomp }
part1(testinput)

puts 'Lets confirm it works with real data Part1 = 1152; Part2 = '
realinput = []
File.open('realinput14').each { |line| realinput << line.chomp }
part1(realinput)


