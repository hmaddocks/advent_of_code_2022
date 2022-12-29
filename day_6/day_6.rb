buffer = File.read('signal.txt')

s = buffer.chars.each_cons(4)
          .find { |c| c.uniq == c }
          .join
p buffer.index(s) + 4

s = buffer.chars.each_cons(14)
          .find { |c| c.uniq == c }
          .join
p buffer.index(s) + 14
