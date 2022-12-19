defmodule Day6 do
  def part_1 do
    File.read!('signal.txt')
    |> String.to_charlist()
    |> Enum.chunk_every(4, 1)
    |> Enum.with_index()
    |> Enum.find(fn {chunk, _} -> Enum.uniq(chunk) == chunk end)
  end

  def part_2 do
    File.read!('signal.txt')
    |> String.to_charlist()
    |> Enum.chunk_every(14, 1)
    |> Enum.with_index()
    |> Enum.find(fn {chunk, _} -> Enum.uniq(chunk) == chunk end)
  end
end

{chunk, index} = Day6.part_1()
IO.puts("#{chunk} #{index + 4}")

{chunk, index} = Day6.part_2()
IO.puts("#{chunk} #{index + 14}")

