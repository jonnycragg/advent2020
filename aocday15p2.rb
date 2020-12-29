def part1(numbers,stopat)
  #puts "entering loop with #{numbers} and length = #{numbers.length} and stopat =  #{stopat}"
  prevNumHash = numbers.slice(0,numbers.length-1)
  numberHash = {}
  prevNumHash.each_with_index {|v, i| numberHash[v] = i}
  #puts("my hash = #{numberHash}")
  while numbers.length <= stopat
    if !numberHash.has_key?(numbers[numbers.length-1])
      numbers.append(0)
      numberHash[numbers[numbers.length-2]] = numbers.length-2
    else
      low_index = numberHash[numbers[numbers.length-1]]
      high_index = numbers.length-1
      numbers.append(high_index - low_index)
      numberHash[numbers[numbers.length-2]] = numbers.length-2
    end
  end
  return numbers[stopat-1]
end

# lets check with test data
puts "Answer should be 436 => #{part1([0,3,6],2020)}"
puts "Answer should be 1 => #{part1([1,3,2],2020)}"
puts "Answer should be 10 => #{part1([2,1,3],2020)}"
puts "Answer should be 27 => #{part1([1,2,3],2020)}"
puts "Answer should be 78 => #{part1([2,3,1],2020)}"
puts "Answer should be 438 => #{part1([3,2,1],2020)}"
puts "Answer should be 1836 => #{part1([3,1,2],2020)}"
puts "Answer should be 763 => #{part1([0,14,1,3,7,9],2020)}"

# lets check with more data
puts "Answer should be 175594 => #{part1([0,3,6],30000000)}"
puts "Answer should be 2578 => #{part1([1,3,2],30000000)}"
puts "Answer should be 3544142 => #{part1([2,1,3],30000000)}"
puts "Answer should be 261214 => #{part1([1,2,3],30000000)}"
puts "Answer should be 6895259 => #{part1([2,3,1],30000000)}"
puts "Answer should be 18 => #{part1([3,2,1],30000000)}"
puts "Answer should be 362 => #{part1([3,1,2],30000000)}"
puts "Answer should be ???? => #{part1([0,14,1,3,7,9],30000000)}"
