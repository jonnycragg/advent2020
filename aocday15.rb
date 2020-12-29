def part1(numbers,stopat)
  puts "entering loop with #{numbers} and length = #{numbers.length} and stopat =  #{stopat}"
  while numbers.length <= stopat
    #prevNums = numbers.slice(0,numbers.length-1)
    prevNums = numbers
    puts "prev numbers = #{prevNums} and checking if #{numbers[numbers.length-1]} is in prev nums"
    if !prevNums.include?(numbers[numbers.length-1])
      numbers.append(0)
      puts "current number list = #{numbers}"
    else
      puts "this number #{numbers[numbers.length-1]} is in it so checking where"
      numbers.append(find_last_occurences_diff(prevNums,numbers[numbers.length-1]))
      puts "current number list = #{numbers}"
    end
  end
  puts "leaving loop with #{numbers} and #{stopat} and that = #{numbers[stopat-1]}"
  return numbers[stopat-1]
end

def find_last_occurences_diff(list,num)
  low_index = 0
  high_index = 0
  found = false
  list.reverse.each_with_index do |x, index|
    puts "searchin in reverse order #{x} and #{index}"
    if x == num
      if high_index == 0
        high_index = list.length - index
        puts "high index = #{high_index}"
      else
        puts "index = #{index} and list length =#{list.length}"
        low_index = (index+1) - (list.length-1)
        puts "low index = #{low_index}"
        found = true
        break
      end
    end
  end
  if !found
    return 0
  else
    return high_index - low_index
  end
end

# lets check with test data
puts "Answer should be 426 => " + part1([0,3,6],2020)
puts "Answer should be 1 => " + part1([1,3,2],2020)