File.read!('rps.txt')
|> String.split("\n", trim: true)
|> Enum.reduce(0, fn turn, acc ->
  [g, h] =
    %{
      "A X" => [3, 1],
      "A Z" => [0, 3],
      "A Y" => [6, 2],
      "B X" => [0, 1],
      "B Z" => [6, 3],
      "B Y" => [3, 2],
      "C X" => [6, 1],
      "C Z" => [3, 3],
      "C Y" => [0, 2]
    }[turn]

  acc + g + h
end)
|> IO.puts()

File.read!('rps.txt')
|> String.split("\n", trim: true)
|> Enum.reduce(0, fn turn, acc ->
  [g, h] =
    %{
      "A X" => [0, 3],
      "A Z" => [6, 2],
      "A Y" => [3, 1],
      "B X" => [0, 1],
      "B Z" => [6, 3],
      "B Y" => [3, 2],
      "C X" => [0, 2],
      "C Z" => [6, 1],
      "C Y" => [3, 3]
    }[turn]

  acc + g + h
end)
|> IO.puts()
