defmodule Day4 do
  def overlaps([left, right]) do
    right.first == left.first || Enum.member?(left, right.first) ||
      Enum.member?(right, left.first)
  end

  def covers([left, right]) do
    (left.first <= right.first && left.last >= right.last) ||
      (right.first <= left.first && right.last >= left.last)
  end

  def convert_to_range([b, e]) do
    String.to_integer(b)..String.to_integer(e)//1
  end

  def convert_to_range(line) do
    line
    |> String.split(",")
    |> Enum.map(&String.split(&1, "-"))
    |> Enum.map(&convert_to_range/1)
  end

  def convert_to_ranges(lines) do
    lines
    |> Enum.reject(fn line -> String.length(line) == 0 end)
    |> Enum.map(&convert_to_range/1)
  end

  def part_1 do
    File.read!("cleanup.txt")
    |> String.split("\n")
    |> Day4.convert_to_ranges()
    |> Enum.filter(&covers/1)
    |> Enum.count()
  end

  def part_2 do
    File.read!("cleanup.txt")
    |> String.split("\n")
    |> Day4.convert_to_ranges()
    |> Enum.filter(&overlaps/1)
    |> Enum.count()
  end
end

Day4.part_1()
|> IO.inspect()

Day4.part_2()
|> IO.puts()
