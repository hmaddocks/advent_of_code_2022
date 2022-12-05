input = File.readlines('stacks.txt', chomp: true)
stack_map = input[0..7]

stacks = stack_map.collect do |row|
  row.match(/.(.). .(.). .(.). .(.). .(.). .(.). .(.). .(.).? ?.?(.)?.?/).captures
end.transpose.map do |stack|
  stack.each.select { |crate| !crate.nil? && crate != ' ' }
end

commands = input[10..].collect do |command|
  m = command.match(/move (\d+) from (\d+) to (\d+)/)
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
  stack.each.select { |crate| !crate.nil? && crate != ' ' }
end

commands.each do |command|
  stacks[command[:to]].unshift(stacks[command[:from]].shift(command[:take]))
  stacks[command[:to]].flatten!
end

top_crates = stacks.map(&:shift).join
p top_crates # CJVLJQPHS
