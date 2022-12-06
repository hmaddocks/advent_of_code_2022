{chunk, index} = File.read!('signal.txt')
|> String.to_charlist()
|> Enum.chunk_every(4,1)
|> Enum.with_index
|> Enum.find(fn {chunk, _} -> Enum.uniq(chunk) == chunk end)

IO.puts "#{chunk} #{index + 4}"

{chunk, index} = File.read!('signal.txt')
|> String.to_charlist()
|> Enum.chunk_every(14,1)
|> Enum.with_index
|> Enum.find(fn {chunk, _} -> Enum.uniq(chunk) == chunk end)

IO.puts "#{chunk} #{index + 14}"
