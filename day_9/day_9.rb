input = File.read('input.txt', chomp: true)
movements = input.split("\n").map do |move|
  move.chomp.split
end.map do |direction, distance|
  [direction, distance.to_i]
end

require 'set'

def move_head(head_pos, direction)
  case direction
  when 'L'
    head_pos[0] -= 1
  when 'R'
    head_pos[0] += 1
  when 'U'
    head_pos[1] -= 1
  when 'D'
    head_pos[1] += 1
  end

  head_pos
end

def move_tail(head_pos, tail_pos)
  if head_pos[0] != tail_pos[0]
    tail_pos[0] += (head_pos[0] - tail_pos[0]).positive? ? 1 : -1
  end

  if head_pos[1] != tail_pos[1]
    tail_pos[1] += (head_pos[1] - tail_pos[1]).positive? ? 1 : -1
  end

  tail_pos
end

def move(direction, head_pos, tail_pos)
  head_pos = move_head(head_pos, direction)
  move_tail(head_pos, tail_pos) unless (head_pos[0] - tail_pos[0]).abs <= 1 && (head_pos[1] - tail_pos[1]).abs <= 1
end

def apply_movements(visited_cells, movements, head_pos, tail_pos)
  return visited_cells if movements.empty?

  direction, distance = movements.shift
  distance.times do
    visited_cells << move(direction, head_pos, tail_pos)
  end

  apply_movements(visited_cells, movements, head_pos, tail_pos)
end

def part_1(input, movements)
  head_pos = [0, 0]
  tail_pos = [0, 0]
  visited_cells = Set[tail_pos]
  visited_cells = apply_movements(visited_cells, movements, head_pos, tail_pos)
  visited_cells.size
end

pp part_1(input, movements) # 6197
