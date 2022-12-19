# input = File.readlines('input.txt', chomp: true)
input = [
  "30373",
  "25512",
  "65332",
  "33549",
  "35390"
].collect do |row|
  row.chars
end

pp input

height = input.length
width = input[0].length

map = [Array.new(width, 1)]
(height - 2).times do
  map << [1, Array.new(width - 2, 0), 1].flatten
end
map << Array.new(width, 1)

def check_top_left(input, x, y, map)
  p input[y][x]
end

def check_top_right(input, x, y), map
  p input[y][x]
end

def check_bottom_left(input, x, y, map)
  p input[y][x]
end

def check_bottom_right(input, x, y, map)
  p input[y][x]
end

count = 0
map.each_with_index do |row, y|
  next if y == 0 || y == height - 1

  row.each_with_index do |tree, x|
    next if x == 0 || x == width - 1

    if y < height / 2
      if x < width / 2
        check_top_left(input, x, y, map)
      else
        check_top_right(input, x, y, map)
      end
    else
      if x < width / 2
        check_bottom_left(input, x, y, map)
      else
        check_bottom_right(input, x, y, map)
      end
    end
  end
end

require 'pp'
pp map
