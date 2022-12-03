p File.readlines('calories.txt', chomp: true)
      .slice_after { |v| v.strip.empty? }
      .map { |arr| arr.map(&:to_i) }
      .map(&:sum)
      .max

