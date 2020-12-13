# frozen_string_literal: true
def change_direction(wp, i, degrees)
   puts "changing dir of wp from wp at #{wp} by #{degrees} #{i}"
   current_wp = wp
   new_wp = []
   while degrees > 0
    degrees -= 90
    if i == 'R'
      new_wp[0] = current_wp[1]
      new_wp[1] = current_wp[0] * -1
      current_wp = new_wp.clone
    end
    if i == 'L'
      new_wp[1] = current_wp[0]
      new_wp[0] = current_wp[1] * -1
      current_wp = new_wp.clone
    end
  end
  return new_wp
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
    puts "Moving waypoint by NESW instructions: i = #{i} d = #{d}"
    waypoint[lattitude] = waypoint[lattitude] + d if i == 'N'
    waypoint[lattitude] = waypoint[lattitude] - d if i == 'S'
    waypoint[longitude] = waypoint[longitude] + d if i == 'E'
    waypoint[longitude] = waypoint[longitude] - d if i == 'W'
    puts "Moving waypoint NESW so new waypoint = #{waypoint}"

    waypoint = change_direction(waypoint,i,d) if i == 'L' || i == 'R'
    puts "new wp direction = #{waypoint}" if i == 'L' || i == 'R'

    if i == 'F'
      puts "Moving #{ship} by #{d} * #{waypoint} so ...."
      ship[lattitude] += waypoint[lattitude] * d
      ship[longitude] += waypoint[longitude] * d
      puts ".... new ship = #{ship}"
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

