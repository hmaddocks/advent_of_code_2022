use array_tool::vec::Intersect;
use std::fs::File;
use std::io::{self, BufRead};

fn part_1() -> u32 {
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

            let item = intersection[0] as u32;
            acc + if item > 90 { item - 96 } else { item - 38 }
        });
    }
    score
}

fn find_badge(rucksacks: &[String]) -> u32 {
    let first = &rucksacks[0];
    let second = &rucksacks[1];
    let third = &rucksacks[2];
    let intersection = first
        .chars()
        .collect::<Vec<_>>()
        .intersect(second.chars().collect::<Vec<_>>())
        .intersect(third.chars().collect::<Vec<_>>());
    let item = intersection[0] as u32;
    if item > 90 {
        item - 96
    } else {
        item - 38
    }
}

fn part_2() -> u32 {
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
