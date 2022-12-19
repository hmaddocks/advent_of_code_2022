use array_tool::vec::Intersect;
use std::fs::File;
use std::io::{self, BufRead};

fn part_1() -> i32 {
    let mut score = 0;
    if let Ok(file) = File::open("../rucksack.txt") {
        let lines = io::BufReader::new(file).lines();
        score = lines.flatten().fold(0, |acc, line| {
            let left = &line[..(line.len()) / 2];
            let right = &line[line.len() / 2..];

            let intersection = left
                .chars()
                .collect::<Vec<_>>()
                .intersect(right.chars().collect::<Vec<_>>());

            let item = intersection[0];
            acc + match item {
                'A'..='Z' => item as i32 - 38,
                'a'..='z' => item as i32 - 96,
                _ => panic!(),
            }
        });
    }
    score
}

fn find_badge(rucksacks: &[String]) -> i32 {
    let first = &rucksacks[0];
    let second = &rucksacks[1];
    let third = &rucksacks[2];
    let intersection = first
        .chars()
        .collect::<Vec<_>>()
        .intersect(second.chars().collect::<Vec<_>>())
        .intersect(third.chars().collect::<Vec<_>>());
    let item = intersection[0];
    match item {
        'A'..='Z' => item as i32 - 38,
        'a'..='z' => item as i32 - 96,
        _ => panic!(),
    }
}

fn part_2() -> i32 {
    let mut badges = 0;
    if let Ok(file) = File::open("../rucksack.txt") {
        let lines = io::BufReader::new(file).lines();
        badges = lines
            .flatten()
            .collect::<Vec<_>>()
            .chunks(3)
            .fold(0, |acc, chunk| {
                let badge = find_badge(chunk);
                acc + badge
            });
    }
    badges
}

fn main() {
    dbg!(part_1());
    dbg!(part_2());
}
