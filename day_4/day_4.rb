def convert_to_ranges(lines)
  lines.collect do |line|
    line.split(',')
        .map { |pair| pair.split('-') }
        .map { |b, e| [b.to_i, e.to_i] }
        .map { |r| Range.new(*r) }
  end
end

ranges = convert_to_ranges(File.readlines('cleanup.txt', chomp: true))

covers = ranges.select do |left, right|
  left.cover?(right) || right.cover?(left)
end

p covers.count

overlaps = ranges.select do |left, right|
  right.begin == left.begin || left.cover?(right.begin) || right.cover?(left.begin)
end

p overlaps.count
