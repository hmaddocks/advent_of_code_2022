buffer = File.read("signal.txt")

p buffer.chars.each_cons(4).find.with_index { |c, i|
  if c.uniq == c
    p i + 4
    true
  else
    false
  end
}

p buffer.chars.each_cons(14).find.with_index { |c, i|
  if c.uniq == c
    p i + 14
    true
  else
    false
  end
}
