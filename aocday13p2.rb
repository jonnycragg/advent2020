def calc_times_around_estimate(k,est)
  buses_est = []
  first_poss_bus, remaining = est.divmod(k)
  first_poss_bus = first_poss_bus * k
  next_poss_bus = first_poss_bus + k
  puts "est = #{est} and first bus = #{first_poss_bus} and next bus = #{next_poss_bus}"
  buses_est.push(first_poss_bus)
  while next_poss_bus <= est+k
    buses_est.push(next_poss_bus)
    next_poss_bus += k
  end
  return buses_est
end

def create_timetable(buses,estimate)
  timetable = {}
  buses.each do |id|
    timetable[id.to_i] = [] if !(id == "x")
  end
  timetable.each_key { |key| timetable[key] = calc_times_around_estimate(key,estimate) }
  puts "Timetable = #{timetable}"
  return timetable
end

def find_earliest_bus(timetable,est)
  puts "find earliest bus in #{timetable} for estimate time of arrival = #{est}"
  possbus = 0
  posstime = 0
  timetable.each_key do |key|
    #puts "I am checking key #{key}"
    timetable[key].each do |bus_time|
      #puts "I am checking key #{key} bus times #{bus_time}"
      # bus too early, next
      if bus_time < est
        next
      end
      # bus at same time as est, catch it!
      if bus_time == est
        return [key, bus_time]
      end
      # bus after est, possible catch, save and keep checking
      if bus_time > est
        if possbus == 0
          possbus = key
          posstime = bus_time
        end
        if bus_time < posstime
          possbus = key
          posstime = bus_time
        end
      end
    end
  end
  return [possbus, posstime]
end

def check_buses_here(check,buses)
  buses.each do |id|
    puts "in check_buses here checking bus #{id} against check #{check}"
    if check % id == 0
      return true
    end
  end
  return false
end

def part1(lines)
  puts "input = #{lines}"
  estimate = lines[0].to_i
  buses = lines[1].split(",")

  #puts "input = #{lines}"
  #buses = lines
  #puts "buses = #{buses}"

  # loop for time t until we have a bus departing one minute after the other in the sequence provided
  t = buses[0].to_i  # t must be the first bus in schedule
  puts "entering time loop with t = #{t} "
  allbuses = []
  buses.each do |id|
    if id.eql?('x')
      next
    else
      allbuses.push(id.to_i)
    end
  end
  puts "All buses to check = #{allbuses}"
  firstbus = buses[0].to_i
  loopcount = 0
  while true
    loopcount += 1
    if loopcount == 1000000
      puts "still here at #{loopcount} and with buses #{buses} and time = #{t}"
    end
    if loopcount == 10000000
      puts "still here at #{loopcount} and with buses #{buses} and time = #{t}"
    end
    if loopcount == 100000000
      puts "still here at #{loopcount} and with buses #{buses} and time = #{t}"
    end
    if loopcount == 1000000000
      puts "still here at #{loopcount} and with buses #{buses} and time = #{t}"
    end
    if loopcount == 10000000000
      puts "still here at #{loopcount} and with buses #{buses} and time = #{t}"
    end
    if loopcount == 100000000000
      puts "still here at #{loopcount} and with buses #{buses} and time = #{t}"
    end
    if loopcount == 1000000000000
      puts "still here at #{loopcount} and with buses #{buses} and time = #{t}"
    end
    found = true
    check = t
    buses.each do |bus|
      if loopcount == 1000000000000 || loopcount == 100000000000 || loopcount == 10000000000 || loopcount == 1000000000 || loopcount == 100000000 || loopcount == 10000000
        puts "Checking each bus #{bus} with check=t= #{check} and found = #{found}"
        puts "#{bus} % #{check}"
      end
      if bus == 'x'
        check += 1
        next
      end
      if check % bus.to_i == 0
        check += 1
      else
        found = false
        break
      end
    end
    break if found
    #puts "Incrementing t = #{t} by itself for next loop"
    t += firstbus  # increment to next time for first bus in schedule
  end
  puts "FOUND IT = #{found} and it is #{t}"
end

puts 'Lets confirm it works with test data Part1 = 1068781; Part2 = '
testinput = []
File.open('testinput13').each { |line| testinput << line.chomp }
part1(testinput)

puts 'Lets confirm it works with test data Part1 = 1261476; Part2 = '
testinput = []
File.open('testinput13p2a').each { |line| testinput << line.chomp }
part1(testinput)

puts 'Lets confirm it works with test data Part1 = 295; Part2 = '
testinput = ['17','x','13','19']
#File.open('testinput13').each { |line| testinput << line.chomp }
#part1(testinput)

puts 'Lets confirm it works with test data Part1 = 295; Part2 = '
testinput = ['67','7','59','61']
#File.open('testinput13').each { |line| testinput << line.chomp }
#part1(testinput)

puts 'Lets confirm it works with test data Part1 = 295; Part2 = '
testinput = ['67','x','7','59','61']
#File.open('testinput13').each { |line| testinput << line.chomp }
#part1(testinput)

puts 'Lets confirm it works with test data Part1 = 295; Part2 = '
testinput = ['67','7','x','59','61']
#File.open('testinput13').each { |line| testinput << line.chomp }
#part1(testinput)

puts 'Lets confirm it works with test data Part1 = 295; Part2 = '
testinput = ['1789','37','47','1889']
#File.open('testinput13').each { |line| testinput << line.chomp }
#part1(testinput)

#puts 'Lets confirm it works with test data Part1 = 295; Part2 = '
#testinput = []
#File.open('testinput13').each { |line| testinput << line.chomp }
#part1(testinput)

puts 'Lets confirm it works with real data Part1 = 1152; Part2 = '
realinput = []
File.open('realinput13').each { |line| realinput << line.chomp }
part1(realinput)

