defmodule Day9 do
  def move_head({x, y}, direction) do
    case direction do
      "L" -> {x - 1, y}
      "R" -> {x + 1, y}
      "U" -> {x, y - 1}
      "D" -> {x, y + 1}
    end
  end

  def move_tail({head_x, head_y}, {tail_x, tail_y}) do
    case {tail_x - head_x, tail_y - head_y} do
      {-2, -2} -> {head_x - 1, head_y - 1}
      {-2, 2} -> {head_x - 1, head_y + 1}
      {2, -2} -> {head_x + 1, head_y - 1}
      {2, 2} -> {head_x + 1, head_y + 1}
      {-2, _} -> {head_x - 1, head_y}
      {2, _} -> {head_x + 1, head_y}
      {_, -2} -> {head_x, head_y - 1}
      {_, 2} -> {head_x, head_y + 1}
      _ -> {tail_x, tail_y}
    end
  end

  def move(direction, head_pos, tail_pos) do
    new_head_pos = move_head(head_pos, direction)
    new_tail_pos = move_tail(new_head_pos, tail_pos)
    {new_head_pos, new_tail_pos}
  end

  def apply_movements(visited_cells, [], _head_pos, _tail_pos) do
    visited_cells
  end

  def apply_movements(visited_cells, [[direction, distance] | tail], head_pos, tail_pos) do
    {new_visited_cells, new_head_pos, new_tail_pos} =
      Enum.reduce(0..(distance - 1), {visited_cells, head_pos, tail_pos}, fn _,
                                                                             {visited_cells,
                                                                              head_pos,
                                                                              tail_pos} ->
        {new_head_pos, new_tail_pos} = move(direction, head_pos, tail_pos)
        new_visited_cells = MapSet.put(visited_cells, new_tail_pos)
        {new_visited_cells, new_head_pos, new_tail_pos}
      end)

    apply_movements(new_visited_cells, tail, new_head_pos, new_tail_pos)
  end

  def part_1(movements) do
    visited_cells = MapSet.new([{0, 0}])
    visited_cells = apply_movements(visited_cells, movements, {0, 0}, {0, 0})
    length(MapSet.to_list(visited_cells))
  end

  def part_2(movements) do
    visited_cells = MapSet.new([{0, 0}])
    knots = []
    visited_cells = apply_movements(visited_cells, movements, {0, 0}, {0, 0})
    length(MapSet.to_list(visited_cells))
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

movements2 =
  "R 5
U 8
L 8
D 3
R 17
D 10
L 25
U 20"
  |> String.split("\n")
  |> Enum.map(fn line -> String.split(line, " ") end)
  |> Enum.reject(fn x -> length(x) == 1 end)
  |> Enum.map(fn [direction, distance] -> [direction, String.to_integer(distance)] end)

Day9.part_2(movements2)
|> IO.puts()
