File.read!('calories.txt')
|> String.split("\n\n", trim: true)
|> Enum.map(fn group -> group |> String.split("\n", trim: true) end)
|> Enum.map(fn item -> item |> Enum.map(fn item -> item |> String.to_integer end) end)
|> Enum.map(&Enum.sum/1)
|> Enum.max
|> IO.puts

File.read!('calories.txt')
|> String.split("\n\n", trim: true)
|> Enum.map(fn group -> group |> String.split("\n", trim: true) end)
|> Enum.map(fn item -> item |> Enum.map(fn item -> item |> String.to_integer end) end)
|> Enum.map(&Enum.sum/1)
|> Enum.sort
|> Enum.slice(-3, 3)
|> Enum.sum
|> IO.puts