use std::fs::File;
use std::io::{self, BufRead};

fn main() {
    let Ok(file) = File::open("../calories.txt") else { return };

    let lines = io::BufReader::new(file).lines();
    let mut total = 0;
    let mut accumulator: Vec<i32> = vec![];

    lines.into_iter().for_each(|line| {
        if let Ok(line) = line {
            if line.is_empty() {
                accumulator.push(total);
                total = 0;
            } else {
                total += line.parse::<i32>().unwrap();
            }
        }
    });
    dbg!(accumulator.iter().max());

    accumulator.sort();
    dbg!(accumulator[accumulator.len() - 3..].iter().sum::<i32>());
}
