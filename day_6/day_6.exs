defmodule Day6 do
  def part_1 do
    {_, index} =
      File.read!('signal.txt')
      |> String.to_charlist()
      |> Enum.chunk_every(4, 1)
      |> Enum.with_index()
      |> Enum.find(fn {chunk, _} -> Enum.uniq(chunk) == chunk end)

    index + 4
  end

  def part_2 do
    {_, index} =
      File.read!('signal.txt')
      |> String.to_charlist()
      |> Enum.chunk_every(14, 1)
      |> Enum.with_index()
      |> Enum.find(fn {chunk, _} -> Enum.uniq(chunk) == chunk end)

    index + 14
  end
end

Day6.part_1()
|> IO.puts()

Day6.part_2()
|> IO.puts()
