// def build_stacks(stack_map)
//   stack_map.collect do |row|
//     row.match(/.(.). .(.). .(.). .(.). .(.). .(.). .(.). .(.).? ?.?(.)?.?/).captures
//   end.transpose.map do |stack|
//     stack.each.reject { |crate| crate.nil? || crate == ' ' }
//   end
// end

use std::fs::File;
use std::io::{self, BufRead};

// fn build_stacks(stack_map: Vec<Vec<String>>) -> Vec<Vec<String>> {
//     let stacks: Vec<Vec<String>> = stack_map.iter().map(|row| vec![1, 2, 3, 4]).collect();
//     let rotated_stacks: Vec<Vec<String>> = stacks
//         .transpose()
//         .map(|stack| stack.reject(|crate| crate == " "))
//         .collect();
//     rotated_stacks
// }

struct Command {
    take: u32,
    from: u32,
    to: u32,
};


fn part_1() -> String {
    todo!();
}

fn part_2() -> String {
    todo!();
}

fn main() {
    if let Ok(file) = File::open("../stacks.txt") {
        let lines = io::BufReader::new(file).lines();
        let stack_map = lines.take(7);


        let commands = lines

        dbg!(part_1());
        dbg!(part_2());
    }
}
