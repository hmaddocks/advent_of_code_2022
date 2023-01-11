defmodule Day9 do
  def move_head(head_pos, "L") do
    {x, y} = head_pos
    {x - 1, y}
  end

  def move_head(head_pos, "R") do
    {x, y} = head_pos
    {x + 1, y}
  end

  def move_head(head_pos, "U") do
    {x, y} = head_pos
    {x, y - 1}
  end

  def move_head(head_pos, "D") do
    {x, y} = head_pos
    {x, y + 1}
  end

  defguardp is_positive(n) when n > 0
  defguardp is_negative(n) when n < 0

  def move_tail_x({head_x, _}, {tail_x, tail_y}) when head_x == tail_x,
    do: IO.inspect({tail_x, tail_y}, label: "X equal")

  def move_tail_x({head_x, _}, {tail_x, tail_y}) when abs(head_x - tail_x) < 2,
    do: IO.inspect({tail_x, tail_y}, label: "X < 2 ")

  def move_tail_x({head_x, _}, {tail_x, tail_y}) when is_positive(head_x - tail_x),
    do: IO.inspect({tail_x + 1, tail_y}, label: "X positive")

  def move_tail_x({head_x, _}, {tail_x, tail_y}) when is_negative(head_x - tail_x),
    do: IO.inspect({tail_x - 1, tail_y}, label: "X positive")

  def move_tail_y({_, head_y}, {tail_x, tail_y}) when head_y == tail_y,
    do: IO.inspect({tail_x, tail_y}, label: "Y equal")

  def move_tail_y({_, head_y}, {tail_x, tail_y}) when abs(head_y - tail_y) < 2,
    do: IO.inspect({tail_x, tail_y}, label: "Y < 2")

  def move_tail_y({_, head_y}, {tail_x, tail_y}) when is_positive(head_y - tail_y),
    do: IO.inspect({tail_x, tail_y + 1}, label: "Y negative ")

  def move_tail_y({_, head_y}, {tail_x, tail_y}) when is_negative(head_y - tail_y),
    do: IO.inspect({tail_x, tail_y - 1}, label: "Y negative")

  def move(direction, head_pos, tail_pos) do
    new_head_pos = move_head(head_pos, direction)
    IO.inspect(new_head_pos, label: "head")

    new_tail_pos = move_tail_x(new_head_pos, tail_pos)
    new_tail_pos = move_tail_y(new_head_pos, new_tail_pos)

    IO.inspect(new_tail_pos, label: "tail")
    {new_head_pos, new_tail_pos}
  end

  def apply_movements(visited_cells, [], _head_pos, _tail_pos) do
    visited_cells
  end

  def apply_movements(visited_cells, movements, head_pos, tail_pos) do
    [[direction, distance] | tail] = movements

    {new_visited_cells, new_head_pos, new_tail_pos} =
      Enum.reduce(0..distance, {visited_cells, head_pos, tail_pos}, fn _,
                                                                       {visited_cells, head_pos,
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

  def part_2 do
  end
end

# movements =
#   File.read!('input.txt')
#   |> String.split("\n")
#   |> Enum.map(fn line -> String.split(line, " ") end)
#   |> Enum.reject(fn x -> length(x) == 1 end)
#   |> Enum.map(fn [direction, distance] -> [direction, String.to_integer(distance)] end)

movements =
  "R 4
U 4
L 3
D 1
R 4
D 1
L 5
R 2"
  |> String.split("\n")
  |> Enum.map(fn line -> String.split(line, " ") end)
  |> Enum.reject(fn x -> length(x) == 1 end)
  |> Enum.map(fn [direction, distance] -> [direction, String.to_integer(distance)] end)

Day9.part_1(movements)
|> IO.puts()

Day9.part_2()
|> IO.puts()
