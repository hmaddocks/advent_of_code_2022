#     [D]
# [N] [C]
# [Z] [M] [P]
#  1   2   3
#
# move 1 from 2 to 1
# move 3 from 1 to 3
# move 2 from 2 to 1
# move 1 from 1 to 2

# stacks = [['N', 'Z'], ['D', 'C', 'M'], ['P']]

input = File.readlines('stacks.txt', chomp: true)
stack_map = input[0..7]
# s = "[Q]         [N]             [N]
# [H]     [B] [D]             [S] [M]
# [C]     [Q] [J]         [V] [Q] [D]
# [T]     [S] [Z] [F]     [J] [J] [W]
# [N] [G] [T] [S] [V]     [B] [C] [C]
# [S] [B] [R] [W] [D] [J] [Q] [R] [Q]
# [V] [D] [W] [G] [P] [W] [N] [T] [S]
# [B] [W] [F] [L] [M] [F] [L] [G] [J]"

stacks = stack_map.collect do |row|
  row.match(/.(.). .(.). .(.). .(.). .(.). .(.). .(.). .(.).? ?.?(.)?.?/).captures
end.transpose.map do |stack|
  stack.each.select { |crate| !crate.nil? && crate != " " }
end

# command_inputs = [
#   "move 1 from 2 to 1",
#   "move 3 from 1 to 3",
#   "move 2 from 2 to 1",
#   "move 1 from 1 to 2"
# ]
commands = input[10..].collect do |command|
  m = command.match /move (\d+) from (\d+) to (\d+)/
  { take: m[1].to_i, from: m[2].to_i - 1, to: m[3].to_i - 1 }
end

commands.each do |command|
  command[:take].times do
    stacks[command[:to]].unshift(stacks[command[:from]].shift)
  end
end

top_crates = stacks.map(&:shift).join
p top_crates # FJSRQCFTN

stacks = stack_map.collect do |row|
  row.match(/.(.). .(.). .(.). .(.). .(.). .(.). .(.). .(.).? ?.?(.)?.?/).captures
end.transpose.map do |stack|
  stack.each.select { |crate| !crate.nil? && crate != " " }
end

commands.each do |command|
  # command[:take].times do
  stacks[command[:to]].unshift(stacks[command[:from]].shift(command[:take]))
  # end
end
