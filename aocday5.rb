def part1(instructions)
  highest = 0
  boarding_passes = []
  instructions.each do |i|
    a = [*0..127]
    b = [*0..7]
    i.each_char do |instr|
      # puts "processing #{instr} instruction on #{a}"
      if a.length == 1
        if instr.eql?("L")
          # puts "in L"
          b.slice!(b.length / 2, b.length)
        end
        if instr == 'R'
          # puts "in R"
          b.slice!(0, b.length / 2)
        end
      end
      if instr.eql?("F")
        # puts "in F"
        a.slice!(a.length / 2, a.length)
      end
      if instr == 'B'
        # puts "in B"
        a.slice!(0, a.length / 2)
      end
    end
    # puts "We are in row #{a} and col #{b} so thats seat #{a[0]*8+b[0]}"
    seat = a[0] * 8 + b[0]
    boarding_passes.append(seat)
    highest = seat if seat > highest
  end
  puts "Highest seat id = #{highest}"
  puts "Number of seats taken = #{boarding_passes.length}"
  puts "Seats taken = #{boarding_passes}"
  puts "Sorted seat numbers = #{boarding_passes.sort!}"
  boarding_passes.each_with_index do |seat, i|
    # puts "I am at this seat #{seat}, lets check with next seat #{boarding_passes[i+1]}"
    if i != boarding_passes.length-1
      puts "This might be my seat between #{seat} and #{boarding_passes[i + 1]}" if boarding_passes[i + 1] - seat > 1
    end
  end
end

puts 'Lets confirm it works with test data Part1: 44*8+5=357; 70*8+7=567; 14*8+7=119; 102*8+4=820'
testinput = []
File.open('testinput5').each { |line| testinput << line.chomp }
part1(testinput)

puts 'Lets now use the real data'
realinput = []
File.open('inputday5').each { |line| realinput << line.chomp }
part1(realinput)
