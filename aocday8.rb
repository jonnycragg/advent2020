$program = []
$counter = 0
$run = 0
def loadprogram(lines)
  line = 0
  lines.each do |i|
    instruction = []
    linevalues = i.split(" ")
    instruction[0] = line
    instruction[1] = linevalues[0]
    instruction[2] = linevalues[1][0]
    instruction[3] = linevalues[1][1..linevalues[1].length-1]
    instruction[4] = 0
    $program.push(instruction)
    line += 1
    #puts "This line instructions = #{instruction}"
  end
  puts "The loaded program = #{$program}"
end

def execute(instructionNum)
  $run += 1
  next_instruction = 0
  if instructionNum > $program.length
    return true
  else
    instruction = $program[instructionNum]
    puts "Processing this instruction = #{instruction}"
    if instruction[4] > 0
      return false
    end
  end

  #puts "Processing this: #{instruction[0]}, #{instruction[1]}, #{instruction[2]}, #{instruction[3]}, #{instruction[4]}, "
  instruction[4] += 1
  case instruction[1]
  when "nop"
    next_instruction = instruction[0] + 1
  when "acc"
    if instruction[2] == "+"
      $counter = $counter + instruction[3].to_i
    end
    if instruction[2] == "-"
      $counter = $counter - instruction[3].to_i
    end
    next_instruction = instruction[0] + 1
  when "jmp"
    if instruction[2] == "+"
      puts "In jmp +: #{instruction[0]} + #{Integer(instruction[3])} = next instruction #{next_instruction}"
      next_instruction = instruction[0] + Integer(instruction[3])
      puts "Next instruction = #{next_instruction}"
    end
    if instruction[2] == "-"
      next_instruction = instruction[0] - Integer(instruction[3])
    end
  end
  puts "Next instruction = #{next_instruction}"
  execute(next_instruction)
end

puts 'Lets confirm it works with test data Part1 = x ; Part2 = '
testinput = []
File.open('testinput8').each { |line| testinput << line.chomp }
loadprogram(testinput)
puts "Program length = #{$program.length} and counter = #{$counter}"
execute(0)
puts "Sooooo i think the counter = #{$counter} and ran #{$run}"

puts 'Lets now use the real data'
$counter = 0
$program = []
realinput = []
File.open('inputday8').each { |line| realinput << line.chomp }
loadprogram(realinput)
puts "Program length = #{$program.length} and counter = #{$counter}"
execute(0)
puts "Sooooo i think the counter = #{$counter} and ran #{$run}"

puts '/nLets find the broken line of code......'
$counter = 0
$program = []
realinput = []
File.open('inputday8').each { |line| realinput << line.chomp }
loadprogram(realinput)
puts "Program length = #{$program.length} and counter = #{$counter}"

# Loop through program and if find nop or jmp then flip it and run, if ran to end finish!
program_temp = $program
program_temp.each do |i|
  if i[1] == "jmp" then
    i[1] = "nop"
    if execute(0) then
      break
    end
  end
  if i[1] == "nop" then
    i[1] = "jmp"
    if execute(0) then
      break
    end
  end



end

if execute(0) then
  puts "Found right instruction! Count = #{$counter}"
else
  puts "Not completed correctly, counter = #{$counter}"
end
puts "Sooooo i think the counter = #{$counter} and ran #{$run}"

