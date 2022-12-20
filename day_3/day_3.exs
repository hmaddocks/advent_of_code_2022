defmodule Day2 do
  def value(code) when code in ?a..?z, do: code - 96
  def value(code) when code in ?A..?Z, do: code - 38

  def part_1 do
    File.read!('rucksack.txt')
    |> String.split("\n", trim: true)
    |> Enum.reduce(0, fn line, acc ->
      {left, right} = String.split_at(line, String.length(line) |> div(2))

      duplicate_item =
        MapSet.intersection(
          left |> String.to_charlist() |> MapSet.new(),
          right |> String.to_charlist() |> MapSet.new()
        )

      acc + value(Enum.at(duplicate_item, 0))
    end)
  end

  def part_2 do
    File.read!('rucksack.txt')
    |> String.split("\n", trim: true)
    |> Enum.chunk_every(3)
    |> Enum.map(fn [a, b, c] ->
      [String.to_charlist(a), String.to_charlist(b), String.to_charlist(c)]
    end)
    |> Enum.map(fn [a, b, c] ->
      MapSet.intersection(
        a |> MapSet.new(),
        b |> MapSet.new()
      )
      |> MapSet.intersection(c |> MapSet.new())
    end)
    |> Enum.map(fn a -> value(Enum.at(a, 0)) end)
    |> Enum.sum()
  end
end

Day2.part_1()
|> IO.puts()

Day2.part_2()
|> IO.inspect()
