# frozen_string_literal: true

$program = []
$new_program = []
$counter = 0
$run = 0
def loadprogram(lines)
  line = 0
  lines.each do |i|
    instruction = []
    linevalues = i.split(' ')
    instruction[0] = line
    instruction[1] = linevalues[0]
    instruction[2] = linevalues[1][0]
    instruction[3] = linevalues[1][1..linevalues[1].length - 1]
    instruction[4] = 0
    $program.push(instruction)
    line += 1
  end
  #puts "The loaded program = #{$program}"
end

def execute(instructionNum)
  $run += 1
  next_instruction = 0
  if instructionNum >= $program.length
    return true
  else
    instruction = $program[instructionNum]
    return false if (instruction[4]).positive?
  end

  instruction[4] += 1
  case instruction[1]
  when 'nop'
    next_instruction = instruction[0] + 1
  when 'acc'
    $counter = $counter + instruction[3].to_i if instruction[2] == '+'
    $counter = $counter - instruction[3].to_i if instruction[2] == '-'
    next_instruction = instruction[0] + 1
  when 'jmp'
    next_instruction = instruction[0] + Integer(instruction[3]) if instruction[2] == '+'
    next_instruction = instruction[0] - Integer(instruction[3]) if instruction[2] == '-'
  end
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
$new_program = $program
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
next_line = 0
count_attempts = 0
loop do
  puts "Been here #{count_attempts += 1}"
  $counter = 0
  $program = []
  loadprogram(realinput)
  $program.each do |i|
    next if i[0] < next_line

    if i[1] == 'jmp'
      i[1] = 'nop'
      next_line = i[0] + 1
      break
    end
    next unless i[1] == 'nop'

    i[1] = 'jmp'
    next_line = i[0] + 1
    break
  end

  if execute(0)
    puts "Found right instruction! Count = #{$counter}"
    break
  end
end
puts "Sooooo i think the counter = #{$counter} and ran #{$run}"
