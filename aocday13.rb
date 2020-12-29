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

def part1(lines)
  puts "input = #{lines}"
  estimate = lines[0].to_i
  buses = lines[1].split(",")
  puts "estimate = #{estimate} and poss buses = #{buses}"
  bus, time = find_earliest_bus(create_timetable(buses, estimate), estimate)
  puts "bus = #{bus} and time of bus = #{time}"
  wait = time - estimate
  answer = bus * wait
  puts "Wait time is actual bus depart #{time} - #{estimate} = #{wait}"
  puts "Answer is bus id #{bus} * wait time #{wait} = #{answer}"
end


puts 'Lets confirm it works with test data Part1 = 295; Part2 = '
testinput = []
File.open('testinput13').each { |line| testinput << line.chomp }
part1(testinput)

puts 'Lets confirm it works with real data Part1 = 1152; Part2 = '
realinput = []
File.open('realinput13').each { |line| realinput << line.chomp }
part1(realinput)
