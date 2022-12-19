defmodule Day1 do
  def part_1 do
    File.read!('calories.txt')
    |> String.split("\n\n", trim: true)
    |> Enum.map(fn group -> group |> String.split("\n", trim: true) end)
    |> Enum.map(fn item -> item |> Enum.map(&String.to_integer/1) end)
    |> Enum.map(&Enum.sum/1)
    |> Enum.max()
  end

  def part_2 do
    File.read!('calories.txt')
    |> String.split("\n\n", trim: true)
    |> Enum.map(fn group -> group |> String.split("\n", trim: true) end)
    |> Enum.map(fn item -> item |> Enum.map(&String.to_integer/1) end)
    |> Enum.map(&Enum.sum/1)
    |> Enum.sort()
    |> Enum.slice(-3, 3)
    |> Enum.sum()
  end
end

Day1.part_1()
|> IO.puts()

Day1.part_2()
|> IO.puts()
