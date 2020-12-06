def part1(lines)
  values = {}
  passports = []
  lines.each do |i|
    lineValues = Hash[i.split(" ").map{|i|i.split(":")}]
    if lineValues.empty?
      passports.append(values.dup)
      values.clear
    else
      values.merge!(lineValues)
    end
  end
  puts "Passport number = #{passports.length} and passport data = #{passports}"
  
  # Has to contain all fields except cid, count valid passports
  validCount = 0
  valid = true
  passports.each { |passport|
    if passport.key?("ecl") && passport.key?("pid") && passport.key?("eyr") && passport.key?("hcl") && passport.key?("byr") && passport.key?("iyr") && passport.key?("hgt")
      valid = true
    else
      valid = false
      next
    end

    # byr (Birth Year) - four digits; at least 1920 and at most 2002.
    puts "Check birth year #{passport["byr"]}"
    if passport["byr"].length.eql?(4) && passport["byr"].to_i >= 1920 && passport["byr"].to_i <= 2002
      valid = true
    else
      valid = false
      next
    end

    # iyr (Issue Year) - four digits; at least 2010 and at most 2020.
    puts "Check issue year #{passport["iyr"]}"
    if passport["iyr"].length.eql?(4) && passport["iyr"].to_i >= 2010 && passport["iyr"].to_i <= 2020
      valid = true
    else
      valid = false
      next
    end

    # eyr (Expiration Year) - four digits; at least 2020 and at most 2030.
    puts "Check exp year #{passport["eyr"]}"
    if passport["eyr"].length.eql?(4) && passport["eyr"].to_i >= 2020 && passport["eyr"].to_i <= 2030
      valid = true
    else
      valid = false
      next
    end

    # hgt (Height) - a number followed by either cm or in:
    puts "Check height #{passport["hgt"]}"
    if height_ok?(passport["hgt"])
      valid = true
    else
      valid = false
      next
    end

    # hcl (Hair Color) - a # followed by exactly six characters 0-9 or a-f.
    puts "Check hair #{passport["hcl"]} length =#{passport["hcl"].length} and last 6 chars = #{passport["hcl"][1..6]}"
    if passport["hcl"].length.eql?(7) && passport["hcl"][0] == "#" && passport["hcl"][1..6].count("^0123456789abcdef").zero?
      valid = true
    else
      valid = false
      next
    end

    # ecl (Eye Color) - exactly one of: amb blu brn gry grn hzl oth.
    puts "Check eyes #{passport["ecl"]}"
    if passport["ecl"].length.eql?(3) && %w[amb blu brn gry grn hzl oth].include?(passport["ecl"])
      valid = true
    else
      valid = false
      next
    end

    # pid (Passport ID) - a nine-digit number, including leading zeroes.
    puts "Check pid #{passport["pid"]}"
    if passport["pid"].length.eql?(9) && passport["pid"].scan(/\D/).empty?
      valid = true
    else
      valid = false
      next
    end
    puts "we found a valid one!"
    validCount += 1
  }
  puts "Number "
  puts "Number of "
  puts "Number of valid passports  = #{validCount}"
end

def height_ok?(string)
  puts string
  puts string.length
  puts "Length= #{string.length} and last 2 chars = #{(string[-2..-1])} and #{string[0..string.length-3]}"

  if string.length > 2 && (string[-2..-1] == "in" || string[-2..-1] == "cm") && string[0..string.length-3].scan(/\D/).empty?
    #  If cm, the number must be at least 150 and at most 193.
    #  If in, the number must be at least 59 and at most 76.
    height = string[0..string.length-2].to_i
    if string[-2..-1] == "in"
      return height >= 59 && height <= 76
    else
      return height >= 150 && height <= 193
    end
  end
  false
end

puts 'Lets confirm it works with test data Part1 = 3 valid; Part2 = '
testinput = []
File.open('testinput4').each { |line| testinput << line.chomp }
part1(testinput)

puts 'Lets confirm it works with more test data, 4 invalid ones?'
testinput = []
File.open('testinput4a').each { |line| testinput << line.chomp }
part1(testinput)

puts 'Lets confirm it works with even more test data, 4 valid ones'
testinput = []
File.open('testinput4aa').each { |line| testinput << line.chomp }
part1(testinput)

puts 'Lets now use the real data'
realinput = []
File.open('inputday4').each { |line| realinput << line.chomp }
part1(realinput)


