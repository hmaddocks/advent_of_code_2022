# p ('a'..'z').to_a.collect {|c| c.ord} # - 96}
# p ('A'..'Z').to_a.collect {|c| c.ord} # - 38}

p File.readlines('rucksack.txt', chomp: true).reduce(0) { |acc, line|
    l = line[0...(line.length / 2)]
    r = line[line.length / 2..]
    duplicate_item = (l.chars & r.chars).first
    acc + if duplicate_item.ord > 90
            duplicate_item.ord - 96
          else
            duplicate_item.ord - 38
          end
  }

badges = File.readlines('rucksack.txt', chomp: true)
             .each_slice(3)
             .collect do |a, b, c|
  (a.chars & b.chars & c.chars).first
end

priority = badges.reduce(0) do |acc, badge|
  acc + if badge.ord > 90
          badge.ord - 96
        else
          badge.ord - 38
        end
end

p priority
