input = File.readlines('input.txt', chomp: true).collect do |row|
  row.chars.map(&:to_i)
end
# input = [
#   "30373",
#   "25512",
#   "65332",
#   "33549",
#   "35390"
# ].collect do |row|
#   row.chars.map(&:to_i)
# end

height = input.length
width = input[0].length

map = [Array.new(width, 1)]
(height - 2).times do
  map << [1, Array.new(width - 2, 0), 1].flatten
end
map << Array.new(width, 1)

def part_one(map, input)
  height = input.length
  width = input[0].length

  (1...height - 1).to_a.each do |y|
    highest = input[y][0]
    (1...width - 1).to_a.each do |x|
      if input[y][x] > highest
        highest = input[y][x]
        map[y][x] = 1
      end
    end

    highest = input[y][width - 1]
    (1...width - 1).to_a.reverse.each do |x|
      if input[y][x] > highest
        highest = input[y][x]
        map[y][x] = 1
      end
    end
  end

  (1...width - 1).to_a.each do |x|
    highest = input[0][x]
    (1...height - 1).to_a.each do |y|
      if input[y][x] > highest
        highest = input[y][x]
        map[y][x] = 1
      end
    end

    highest = input[height - 1][x]
    (1...height - 1).to_a.reverse.each do |y|
      if input[y][x] > highest
        highest = input[y][x]
        map[y][x] = 1
      end
    end
  end

  map.reduce(0) do |acc, row|
    acc + row.reduce(0) do |acc, tree|
      acc + tree
    end
  end
end

pp part_one(map, input)

def score(input, tree_height, x, y)
  height = input.length
  width = input[0].length

  right = 0
  (x...width - 1).to_a.each do |x|
    right += 1
    break if input[y][x + 1] >= tree_height
  end

  left = 0
  (1..x).to_a.reverse.each do |x|
    left += 1
    break if input[y][x - 1] >= tree_height
  end

  down = 0
  (y...height - 1).to_a.each do |y|
    down += 1
    break if input[y + 1][x] >= tree_height
  end

  up = 0
  (1..y).to_a.reverse.each do |y|
    up += 1
    break if input[y - 1][x] >= tree_height
  end

  up * down * left * right
end

def part_two(input)
  input.flat_map.with_index do |row, y|
    row.collect.with_index do |tree, x|
      score(input, tree, x, y)
    end
  end.max
end

pp part_two(input)
