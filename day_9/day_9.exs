defmodule Day9 do
  def move_head(head_pos, "L") do
    [List.first(head_pos) - 1, List.last(head_pos)]
  end

  def move_head(head_pos, "R") do
    [List.first(head_pos) + 1, List.last(head_pos)]
  end

  def move_head(head_pos, "U") do
    [List.first(head_pos), List.last(head_pos) - 1]
  end

  def move_head(head_pos, "D") do
    [List.first(head_pos), List.last(head_pos) + 1]
  end

  def move_tail(head_pos, tail_pos) do
    [x, y] = tail_pos

    if List.first(head_pos) != x do
      if List.first(head_pos) - x > 0 do
        x = x + 1
      else
        x = x - 1
      end
    end

    if List.last(head_pos) != y do
      if List.last(head_pos) - y > 0 do
        y = y + 1
      else
        y = y - 1
      end
    end

    [x, y]
  end

  def move(direction, head_pos, tail_pos) do
    head_pos = move_head(head_pos, direction)

    if abs(List.first(head_pos) - List.first(tail_pos)) > 1 ||
         abs(List.last(head_pos) - List.last(tail_pos)) > 1 do
      move_tail(head_pos, tail_pos)
    end

    {head_pos, tail_pos}
  end

  def apply_movements(visited_cells, [], _head_pos, _tail_pos) do
    visited_cells
  end

  def apply_movements(visited_cells, movements, head_pos, tail_pos) do
    [[direction, distance] | tail] = movements

    Enum.reduce(0..distance, visited_cells, fn _, m ->
      {head_pos, tail_pos} = move(direction, head_pos, tail_pos)
      IO.inspect(head_pos, label: "head")
      MapSet.put(m, tail_pos)
    end)

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

Day9.part_1(movements)
|> IO.puts()

Day9.part_2()
|> IO.puts()
