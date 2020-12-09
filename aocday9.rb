def check_sum(num, preamble)
  j = 0
  i = 0
  answer = false
  while i < preamble.length && !answer do
    j = i+1
    while j < preamble.length && !answer do
      puts "checking #{preamble[i]} and #{preamble[j]}"
      if num == preamble[i]+preamble[j]
        puts "found answer #{num} with checking #{preamble[i]} and #{preamble[j]}"
        return true
      end
      j += 1
    end
    i += 1
  end
  return false
end

def part1(lines, preamble_num)
  non_calc = 0
  numbers = []
  lines.each do |i|
    numbers.append(i.to_i)
  end
  puts "number length = #{numbers.length} and numbers  = #{numbers}"

  # Get past initial preamble
  pointer = preamble_num

  # start after pre-amble
  # check last 5 combination = current number, if not stop
  # calc new preamble and repeat
  preamble = numbers[pointer-preamble_num..pointer-1]
  puts "preamble = #{preamble}"

  # from pointer lets check that number and loop!
  while true
    puts "Pointer=#{pointer} checking if num #{numbers[pointer]} is calculable from sum in preamble #{preamble}"
    if !check_sum(numbers[pointer], preamble)
      puts "This number #{numbers[pointer]} is not calculable from #{preamble}. We are done!"
      non_calc = numbers[pointer]
      break
    end
    pointer += 1
    preamble = numbers[pointer-preamble_num..pointer-1]
  end

  # part 2
  # find continuous set of numbers that add up to the not calculable number
  puts "non calc number = #{non_calc}"
  puts "NUmbers length = #{numbers.length}"
  # loop through numbers set and add up each item until sum = > non calc
  # if = then we found it and add together smallest and largest number in this contiguous range
  # if > then start again from next number in number list
  found = false
  pointer = 0
  sum = 0
  puts "Numbers length = #{numbers.length} and number set = #{numbers}"
  puts "Pointer = #{pointer} and points to #{numbers[pointer]}"
  puts "Sum = #{sum} and found = #{found}"
  while pointer < numbers.length && !found
    contig_set = []
    i = pointer
    #puts "contig set = #{contig_set} and i = #{i}"
    while i < numbers.length do
      sum += numbers[i]
      #puts "sum currently = #{sum} after adding #{numbers[i]}"
      contig_set.append(numbers[i])
      if sum > non_calc
        #puts "it aint this contig set, try another"
        sum = 0
        break
      end
      if sum == non_calc then
        contig_set = contig_set.sort
        puts "Done! #{sum} smallest = #{contig_set[0]} + #{contig_set[contig_set.length-1]} = #{contig_set[0] + contig_set[contig_set.length-1]}"
        found = true
        break
      end
      i += 1
    end
    pointer += 1
  end
end


puts 'Lets confirm it works with test data Part1 =127 ; Part2 = '
testinput = []
File.open('testinput9').each { |line| testinput << line.chomp }
part1(testinput,5)

puts 'Lets confirm it works with real data'
realinput = []
File.open('realinput9').each { |line| realinput << line.chomp }
part1(realinput,25)
