# p ('a'..'z').to_a.collect {|c| c.ord} # - 96}
# p ('A'..'Z').to_a.collect {|c| c.ord} # - 38}

p File.readlines('rucksack.txt', chomp: true).reduce(0) { |acc, line|
	l, r = line[..(line.length / 2) - 1], line[line.length / 2..]
	duplicate_item = (l.chars & r.chars).first
	acc += duplicate_item.ord > 90 ? duplicate_item.ord - 96 : duplicate_item.ord - 38
}

x = File.readlines('rucksack.txt', chomp: true).each_slice(3).collect do |a, b, c|
	(a.chars & b.chars & c.chars).first
end.reduce(0) { |acc, badge|
	acc	+= badge.ord > 90 ? badge.ord - 96 : badge.ord - 38
}

p x
