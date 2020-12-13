# frozen_string_literal: true
def change_direction(ship, i, degrees)
  direction = ship[2]
  puts "changing dir from ship pointing #{direction} by #{degrees} #{i}"
  while degrees > 0
    degrees -= 90
    if i == 'L' && direction == 'N'
      direction = 'W'
      next
    end
    if i == 'L' && direction == 'S'
      direction = 'E'
      next
    end
    if i == 'L' && direction == 'E'
      direction = 'N'
      next
    end
    if i == 'L' && direction == 'W'
      direction = 'S'
      next
    end
    if i == 'R' && direction == 'N'
      direction = 'E'
      next
    end
    if i == 'R' && direction == 'S'
      direction = 'W'
      next
    end
    if i == 'R' && direction == 'E'
      direction = 'S'
      next
    end
    if i == 'R' && direction == 'W'
      direction = 'N'
      next
    end
  end
  return direction
end

def part1(lines)
  instructions = []
  lines.each do |i|
    #puts "Line values being processed = #{i} "
    command = i[0]
    unit = i[1, i.length - 1].to_i
    instructions.push([command, unit])
  end
  puts "Line values being processed = #{instructions} "
  # Action N means to move north by the given value.
  # Action S means to move south by the given value.
  # Action E means to move east by the given value.
  # Action W means to move west by the given value.
  # Action L means to turn left the given number of degrees.
  # Action R means to turn right the given number of degrees.
  # Action F means to move forward by the given value in the direction the ship is currently facing.
  ship = [0, 0, 'E']
  waypoint = [10,1]
  longitude = 0
  lattitude = 1
  direction = 2
  puts "Starting ship = #{ship}"
  puts "Starting waypoint = #{waypoint}"
  instructions.each do |i, d|
    puts "Moving waypoint by instructions: i = #{i} d = #{d}"
    ship[lattitude] = ship[lattitude] + d if i == 'N'
    ship[lattitude] = ship[lattitude] - d if i == 'S'
    ship[longitude] = ship[longitude] + d if i == 'E'
    ship[longitude] = ship[longitude] - d if i == 'W'
    puts "Moving ship NESW so new ship = #{ship}"

    ship[direction] = change_direction(ship,i,d) if i == 'L' || i == 'R'
    puts "new ship direction = #{ship}" if i == 'L' || i == 'R'

    if i == 'F'
      ship[lattitude] = ship[lattitude] + d if ship[direction] == 'N'
      ship[lattitude] = ship[lattitude] - d if ship[direction] == 'S'
      ship[longitude] = ship[longitude] + d if ship[direction] == 'E'
      ship[longitude] = ship[longitude] - d if ship[direction] == 'W'
      puts "Moving ship forward so new ship = #{ship}"
    end
  end
  puts "We  have finished, ship is #{ship}"
  manhattan = ship[longitude].abs + ship[lattitude].abs
  puts "Manhattan distance (abs) = #{ship[longitude].abs} + #{ship[lattitude].abs} = #{manhattan}"
end

puts 'Lets confirm it works with test data Part1 = 25; Part2 = '
testinput = []
File.open('testinput12').each { |line| testinput << line.chomp }
part1(testinput)

puts 'Lets confirm it works with real data Part1 = 1152; Part2 = '
realinput = []
File.open('realinput12').each { |line| realinput << line.chomp }
part1(realinput)
