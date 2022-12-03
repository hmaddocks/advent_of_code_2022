# A for Rock,
# B for Paper,
# C for Scissors.

# 1 for Rock,
# 2 for Paper
# 3 for Scissors

p File.readlines('rps.txt', chomp: true).reduce(0) { |acc, line|
  _, us = line.split(" ")
  g, h = {
    "A X" => [3, 1],
    "A Z" => [0, 3],
    "A Y" => [6, 2],
    "B X" => [0, 1],
    "B Z" => [6, 3],
    "B Y" => [3, 2],
    "C X" => [6, 1],
    "C Z" => [3, 3],
    "C Y" => [0, 2]
  }[line]
  acc + g + h
}

# X means you need to lose,
# Y means you need to end the round in a draw, and
# Z means you need to win.

p File.readlines('rps.txt', chomp: true).reduce(0) { |acc, line|
  _, us = line.split(" ")
  g, h = {
    "A X" => [0, 3], # Scissors
    "A Z" => [6, 2], # Paper
    "A Y" => [3, 1], # Rock
    "B X" => [0, 1], # Rock
    "B Z" => [6, 3], # Scissors
    "B Y" => [3, 2], # Paper
    "C X" => [0, 2], # Paper
    "C Z" => [6, 1], # Rock
    "C Y" => [3, 3]  # Scissors
  }[line]
  acc + g + h
}
