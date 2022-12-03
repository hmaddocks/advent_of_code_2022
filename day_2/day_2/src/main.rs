use std::collections::HashMap;
use std::fs::File;
use std::io::{self, BufRead};

fn main() {
    let u = HashMap::from([("X", 1), ("Y", 2), ("Z", 3)]);
    let g = HashMap::from([
        ("A X".to_owned(), 3),
        ("A Z".to_owned(), 0),
        ("A Y".to_owned(), 6),
        ("B X".to_owned(), 0),
        ("B Z".to_owned(), 6),
        ("B Y".to_owned(), 3),
        ("C X".to_owned(), 6),
        ("C Z".to_owned(), 3),
        ("C Y".to_owned(), 0),
    ]);

    let Ok(file) = File::open("../rps.txt") else { return };

    let lines = io::BufReader::new(file).lines();
    let score = lines.flatten().fold(0, |acc, line| {
        let us = line.split(' ').last().unwrap();
        let x = u[&us];
        let y = g[&line];
        acc + x + y
    });
    dbg!(score);
}
