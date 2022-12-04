p File.readlines('calories.txt', chomp: true)
      .slice_after { |line| line.strip.empty? }
      .map { |group| group.map(&:to_i) }
      .map(&:sum)
      .max

p File.readlines('calories.txt', chomp: true)
      .slice_after { |line| line.strip.empty? }
      .map { |group| group.map(&:to_i) }
      .map(&:sum)
      .sort[-3..]
      .sum
