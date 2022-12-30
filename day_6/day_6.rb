buffer = File.read('signal.txt')

_, i = buffer.chars.each_cons(4)
             .with_index
             .find { |c, _i| c.uniq == c }
p i + 4

_, i = buffer.chars.each_cons(14)
             .with_index
             .find { |c, _i| c.uniq == c }
p i + 14
