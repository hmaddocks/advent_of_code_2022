defmodule Day9 do
  #   def move_head(head_pos, direction)
  #     case direction
  #     when 'L'
  #       head_pos[0] -= 1
  #     when 'R'
  #       head_pos[0] += 1
  #     when 'U'
  #       head_pos[1] -= 1
  #     when 'D'
  #       head_pos[1] += 1
  #     end
  #
  #     head_pos
  #   end

  def move_head(head_pos, "L") do
  end

  def move_head(head_pos, "R") do
  end

  def move_head(head_pos, "U") do
  end

  def move_head(head_pos, "D") do
  end

  def move_tail(head_pos, tail_pos) do
    [x, y] = tail_pos

    if head_pos[0] != x do
      if head_pos[0] - x > 0 do
        x = x + 1
      else
        x = x - 1
      end
    end

    if head_pos[1] != y do
      if head_pos[1] - y > 0 do
        y = y + 1
      else
        y = y - 1
      end
    end

    [x, y]
  end

  def move(direction, head_pos, tail_pos) do
    head_pos = move_head(head_pos, direction)

    if abs(head_pos[0] - tail_pos[0]) > 1 || abs(head_pos[1] - tail_pos[1]) > 1 do
      move_tail(head_pos, tail_pos)
    end
  end

  def apply_movements(visited_cells, [], _head_pos, _tail_pos) do
    visited_cells
  end

  def apply_movements(visited_cells, movements, head_pos, tail_pos) do
    [[direction, distance] | tail] = movements

    for _ <- 0..distance do
      move(direction, head_pos, tail_pos)
      |> MapSet.put(visited_cells)
    end

    apply_movements(visited_cells, tail, head_pos, tail_pos)
  end

  def part_1(movements) do
    visited_cells = MapSet.new([0, 0])
    visited_cells = apply_movements(visited_cells, movements, [0, 0], [0, 0])
    length(MapSet.to_list(visited_cells))
  end

  def part_2 do
  end
end

movements =
  File.read!('input.txt')
  |> String.split("\n")
  |> Enum.map(fn line -> String.split(line, " ") end)
  |> Enum.reject(fn x -> length(x) == 1 end)
  |> Enum.map(fn [direction, distance] -> [direction, String.to_integer(distance)] end)

# |> IO.inspect

Day9.part_1(movements)
|> IO.puts()

Day9.part_2()
|> IO.puts()
