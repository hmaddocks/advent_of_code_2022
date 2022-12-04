use array_tool::vec::Intersect;
use std::collections::HashSet;
use std::fs::File;
use std::io::{self, BufRead};

fn main() {
    if let Ok(file) = File::open("../rucksack.txt") {
        let lines = io::BufReader::new(file).lines();
        let score = lines.flatten().fold(0, |acc, line| {
            let left = &line[..(line.len()) / 2];
            let right = &line[line.len() / 2..];

            let intersection = left
                .chars()
                .collect::<Vec<_>>()
                .intersect(right.chars().collect::<Vec<_>>());

            let item = intersection[0] as u32;
            acc + if item > 90 { item - 96 } else { item - 38 }
        });

        dbg!(score);
    }
}
