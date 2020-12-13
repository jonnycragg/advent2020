# frozen_string_literal: true
$step1 = ["#.##.##.##","#######.##","#.#.#..#..","####.##.##","#.##.##.##","#.#####.##","..#.#.....","##########","#.######.#","#.#####.##"]
$step2 = ["#.LL.L#.##","#LLLLLL.L#","L.L.L..L..","#LLL.LL.L#","#.LL.LL.LL","#.LLLL#.##","..L.L.....","#LLLLLLLL#","#.LLLLLL.L","#.#LLLL.##"]
$step3 = []
$step4 = []

def check_all(grid,i_start,j_start,i_inc,j_inc)
  # give me the grid, starting point and i,j increments and loop through by increments
  # and return true if occupied seat found in field of direction on grid else false
  #puts "IN check all and params are: #{i_start}, #{j_start}, #{i_inc}, #{j_inc}"
  return false if (i_start + i_inc) < 0 || (i_start + i_inc) > grid.length-1 || (j_start + j_inc) < 0 || (j_start + j_inc) > grid[0].length-1
  if grid[i_start + i_inc][j_start + j_inc] == 'L'
    return false
  end
  if grid[i_start + i_inc][j_start + j_inc] == '#'
    #puts "found a # at #{i_start + i_inc}, #{j_start + j_inc}"
    return true
  else
    check_all(grid,i_start + i_inc,j_start + j_inc,i_inc,j_inc)
  end

end

def check_around(grid, i, j)
  i_start = 0
  i_finish = grid.length - 1
  j_start = 0
  j_finish = grid[0].length - 1
  count_occupied = 0
  #puts "check around i=#{i}, j=#{j} and value = #{grid[i][j]}"

  # process i
  #puts ">>Process i forward"
  count_occupied += 1 if check_all(grid,i,j,1,0)
  #puts ">>count = #{count_occupied}"

  #puts ">>Process i reverse"
  count_occupied += 1 if check_all(grid,i,j,-1,0)
  #puts ">>count = #{count_occupied}"

  # process j
  #puts ">>Process j forward"
  count_occupied += 1 if check_all(grid,i,j,0,1)
  #puts ">>count = #{count_occupied}"

  #puts ">>Process j reverse"
  count_occupied += 1 if check_all(grid,i,j,0,-1)
  #puts ">>count = #{count_occupied}"

  # process diagonal
  #puts ">>Process corners i+,j+ diagonal"
  count_occupied += 1 if check_all(grid,i,j,1,1)
  #puts ">>Process corners i+,j- diagonal"
  count_occupied += 1 if check_all(grid,i,j,1,-1)
  #puts ">>Process corners i-,j+ diagonal"
  count_occupied += 1 if check_all(grid,i,j,-1,1)
  #puts ">>Process corners i-,j- diagonal"
  count_occupied += 1 if check_all(grid,i,j,-1,-1)


  #puts "occupied count aournd diags = #{count_occupied}"
  count_occupied
end

def part1(lines)
  current_grid = []
  lines.each do |i|
    #puts "Line values being processed = #{i} "
    current_grid.push(i)
  end

  finished = false
  until finished
    #puts "Our current grid = #{current_grid}"
    next_grid = []
    current_grid.each { |e| next_grid << e.dup }
    #puts "Our next grid = #{next_grid}"

    # RULES ARE THESE
    # If seat is empty (L) and no occupied seats adjacent to it, the seat becomes occupied.
    # If seat is occupied (#) and four or more seats adjacent to it are occupied, the seat becomes empty.
    # Otherwise, the seat's state does not change.
    occupied = '#'
    empty = 'L'
    floor = '.'

    # loop through each grid, if '.' skip
    # if L empty count adjacent seats occupied and if 0 then change to occupied
    # if # occupied, count how many occupied adjacent to it and if >= 4 change to L empty
    i = 0
    j = 0
    puts "size of grid = #{current_grid.length} * #{current_grid[0].length}"
    while i < current_grid.length
      #puts " in i outer loop and i = #{i}"
      j = 0
      while j < current_grid[i].length
        current_position = current_grid[i][j]
        #puts "Current grid position = #{current_position}"
        if floor == current_position
          j += 1
          next
        end
        next_grid[i][j] = occupied if empty == current_position && check_around(current_grid, i, j).zero?
        next_grid[i][j] = empty if occupied == current_position && check_around(current_grid, i, j) >= 5
        j += 1
      end
      i += 1
    end
    puts "current grid = #{current_grid}"
    puts "   next grid = #{next_grid}"
    next_grid.each do |g|
      puts "#{g}"
    end
    finished = current_grid == next_grid
    puts "Do grids equal = #{finished}"
    #puts "Does grid equal step1 = #{current_grid == $step1}"
    current_grid = []
    total = 0
    next_grid.each do |e|
      current_grid << e.dup
      total += e.count(occupied)
    end
  end
  puts "We  have finished, total occupied seats = #{total}"
end

puts 'Lets confirm it works with test data Part1 = ; Part2 = '
testinput = []
File.open('testinput11').each { |line| testinput << line.chomp }
part1(testinput)

puts 'Lets confirm it works with real data Part1a = ; Part2 = '
realinput = []
File.open('realinput11').each { |line| realinput << line.chomp }
part1(realinput)

