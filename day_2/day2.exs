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
      # Scissors
      "A X" => [0, 3],
      # Paper
      "A Z" => [6, 2],
      # Rock
      "A Y" => [3, 1],
      # Rock
      "B X" => [0, 1],
      # Scissors
      "B Z" => [6, 3],
      # Paper
      "B Y" => [3, 2],
      # Paper
      "C X" => [0, 2],
      # Rock
      "C Z" => [6, 1],
      # Scissors
      "C Y" => [3, 3]
    }[turn]

  acc + g + h
end)
|> IO.puts()
