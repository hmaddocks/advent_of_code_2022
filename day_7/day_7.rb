# input = [
#   "$ cd /",
#   "$ ls",
#   "dir a",
#   "14848514 b.txt",
#   "8504156 c.dat",
#   "dir d",
#   "$ cd a",
#   "$ ls",
#   "dir e",
#   "29116 f",
#   "2557 g",
#   "62596 h.lst",
#   "$ cd e",
#   "$ ls",
#   "584 i",
#   "$ cd ..",
#   "$ cd ..",
#   "$ cd d",
#   "$ ls",
#   "4060174 j",
#   "8033020 d.log",
#   "5626152 d.ext",
#   "7214296 k"
# ]

def sizes(input)
  sizes = Array.new(200, 0)
  current_path = Array.new(100, 0)
  path_head = 0
  folder_counter = 0

  input.each do |line|
    case line
    when /\$ ls/
      next
    when /\$ cd (.+)/
      if $1 ==  ".."
        path_head -= 1;
      else
        current_path[path_head] = folder_counter;
        folder_counter += 1;
        path_head += 1;
      end
    when /dir/
      next
    else
      file_size = line.split(' ').first.to_i
      path_head.times do |i|
        sizes[current_path[i]] += file_size
      end
      p sizes
    end
  end
  sizes
end

def part_one(sizes)
  sizes.select { |x| x <= 100_000 }.sum
end

def part_two(sizes)
  total_space = 70_000_000
  target_space = 30_000_000
  free_space = total_space - sizes[0]
  target = target_space - free_space
  sizes.select { |x| x >= target }.sort.first
end

require 'pp'
input = File.readlines('input.txt', chomp: true)
sizes = sizes(input)
pp part_one(sizes)
pp part_two(sizes)
