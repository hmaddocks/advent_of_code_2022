use std::collections::HashSet;
use std::fs::File;
use std::io::{self, BufRead};

fn main() {
    if let Ok(file) = File::open("../rucksack.txt") {
        let lines = io::BufReader::new(file).lines();

        let score = lines.flatten().fold(0, |acc, line| {
            let left = &line[..(line.len()) / 2 - 1];
            let right = &line[line.len() / 2..];

            let left_set = left.chars().collect::<HashSet<_>>();
            let right_set = right.chars().collect::<HashSet<_>>();

            let c = left_set.intersection(&right_set).collect::<Vec<_>>();
            // let d = *c as u32;
            dbg!(c);
            // acc += c.len()
            2
        });

        dbg!(score);
    }
    println!("Hello, world!");
}

//     l, r = line[..(line.length / 2) - 1], line[line.length / 2..]
// duplicate_item = (l.chars & r.chars).first
// acc += duplicate_item.ord > 90 ? duplicate_item.ord - 96 : duplicate_item.ord - 38
