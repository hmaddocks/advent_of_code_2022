# p ('a'..'z').to_a.collect {|c| c.ord} # - 96}
# p ('A'..'Z').to_a.collect {|c| c.ord} # - 38}

def char_to_score(char)
  case char
  when 'a'..'z'
    char.ord - 96
  when 'A'..'Z'
    char.ord - 38
  end
end

p File.readlines('rucksack.txt', chomp: true).reduce(0) { |acc, line|
    l = line[0...(line.length / 2)]
    r = line[line.length / 2..]
    duplicate_item = (l.chars & r.chars).first
    acc + char_to_score(duplicate_item)
  }

badges = File.readlines('rucksack.txt', chomp: true)
             .each_slice(3)
             .collect do |a, b, c|
  (a.chars & b.chars & c.chars).first
end

priority = badges.reduce(0) do |acc, badge|
  acc + char_to_score(badge)
end

p priority
