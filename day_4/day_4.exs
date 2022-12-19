defmodule Day4 do
  def overlaps(left, right) do
    right.first == left.first || Enum.member?(left, right.first) ||
      Enum.member?(right, left.first)
  end

  def covers(left, right) do
    left.first <= right.first && left.last >= right.last
  end

  def convert_to_ranges(lines) do
    lines
    |> Enum.reject(fn line -> String.length(line) == 0 end)
    |> Enum.map(fn line ->
      line
      |> String.split(",")
      |> Enum.map(fn pair -> String.split(pair, "-") end)
      |> Enum.map(fn [b, e] -> [String.to_integer(b), String.to_integer(e)] end)
      |> Enum.map(fn [b, e] -> b..e//1 end)
    end)
  end

  def part_1 do
    lines =
      File.read!("cleanup.txt")
      |> String.split("\n")

    Day4.convert_to_ranges(lines)
    |> Enum.filter(fn [left, right] ->
      Day4.covers(left, right) || Day4.covers(right, left)
    end)
    |> Enum.count()
  end

  def part_2 do
    File.read!("cleanup.txt")
    |> String.split("\n")
    |> Day4.convert_to_ranges()
    |> Enum.filter(fn [left, right] ->
      Day4.overlaps(left, right) || Day4.overlaps(right, left)
    end)
    |> Enum.count()
  end
end

Day4.part_1()
|> IO.inspect()

Day4.part_2()
|> IO.puts()
