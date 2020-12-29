def getvalues(validTickets, n)
  puts("get values for n=#{n}")
  values = []
  validTickets.each do |ticket|
    values.append(ticket[n])
  end
  puts("returning values=#{values}")
  return values
end

def allpass(nthvals, rules)
  # code here
  rules.each do |rule|
    passed = false
    nthvals.each do |check|
      if check >= rule[1][0][0] && check <= rule[1][0][1]
        passed = true
        next
      end
      if check >= rule[1][1][0] && check <= rule[1][1][1]
        passed = true
        next
      end
      passed = false
      break
    end
    if passed
      return rule[0]
    end
  end
end

def part1(lines)
  #puts "input = #{lines}"
  rules = {}
  myticket = []
  tickets = []
  i = 0
  while i < lines.length do
    #puts("Line #{i} is #{lines[i]}")

    case lines[i]
    when 'your ticket:'
      myticket = lines[i+1].split(',').map(&:to_i)
      puts("My ticket = #{myticket}")
      i += 2
    when 'nearby tickets:'
      i += 1
      while i < lines.length do
        nearbyticket = lines[i].split(',').map(&:to_i)
        tickets.append(nearbyticket)
        i += 1
      end
      #puts("nearby ticket count = #{tickets.length}")
    when ''
      i += 1
    else
      rule, data = lines[i].split(':')
      ranges = data.split('or').map(&:strip)
      dataset = []
      ranges.each do |range|
        dataset.append(range.split('-').map(&:to_i))
      end
      rules[rule] = dataset
      i += 1
    end
  end
  puts("Rule count = #{rules.length}")
  rules.each do |rule|
    puts("Rule = #{rule}")
  end

  # for each ticket number check it passes all rules
  # if it does not then sum the values that does not pass all rules
  errorcount = 0
  validTickets = []
  countInvalidTickets = 0
  #puts("number of tickets = #{tickets.length}")
  tickets.each do |ticket|
    validTicket = true
    #puts("Ticket processing =  #{ticket}")
    valid = false
    ticket.each do |check|
      #puts("check = #{check}")
      if valid
        break
      end
      rules.each do |rule|
        #puts("rule = #{rule[0]} and ranges = #{rule[1]}")
        if check >= rule[1][0][0] && check <= rule[1][0][1]
          valid = true
          break
        end
        if check >= rule[1][1][0] && check <= rule[1][1][1]
          valid = true
          break
        end
      end
      if !valid
        errorcount += check
        #puts("Found a field not valid for any rule = #{check} and errcount = #{errorcount}")
        validTicket = false
      else
        valid = false
      end
    end
    if validTicket
      validTickets.append(ticket)
    else
      countInvalidTickets += 1
    end
  end
  puts("Error count = #{errorcount}")
  puts("Error count = #{countInvalidTickets}")
  puts("count of valid tickets = #{validTickets.length}")
  validTickets.each do |ticket|
    puts("Ticket=#{ticket}")
  end

  # for each valid ticket, what must be the order of the values?
  # for example, which rule do all the first vales fall into? then second etc
  puts("Lets check the ortder of the rules now...#{rules.length}")
  order = []

  # get all nth values from tickets and check against rth rule
  # if they all pass then this rule must be the 'next' rule so append to list move along
  n = 0
  puts("Part2: n=#{n} to loop for #{rules.length}")
  while n < rules.length
    nthvals = getvalues(validTickets,n)
    puts("Call ORDER with these values: #{nthvals}")
    puts("and these rules #{rules}")
    rulename = allpass(nthvals,rules)
    puts("we returned this rule #{rulename}")
    order.append(rulename)
    n += 1
  end
  puts("rules order = #{order}")
end

puts 'Lets confirm it works with test data Part1 = 25788'
testinput = []
File.open('testinput16').each { |line| testinput << line.chomp }
part1(testinput)

#puts 'Lets confirm it works with real data Part1 = 1152; Part2 = '
#realinput = []
#File.open('realinput13').each { |line| realinput << line.chomp }
#part1(realinput)


