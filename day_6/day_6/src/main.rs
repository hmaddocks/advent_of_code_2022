use itertools::Itertools;
use std::fs;

fn find_unique_stream(input: &[u8], window_size: usize) -> u32 {
    match String::from_utf8_lossy(input)
        .as_bytes()
        .windows(window_size)
        .position(|window| window.iter().unique().count() == window_size)
        .map(|pos| pos + window_size)
    {
        Some(pos) => pos.try_into().unwrap(),
        None => 0,
    }
}

fn part_1(input: &[u8]) {
    let position = find_unique_stream(input, 4);
    println!("{}", position)
}

fn part_2(input: &[u8]) {
    let position = find_unique_stream(input, 14);
    println!("{}", position)
}

fn main() {
    match &fs::read("../signal.txt") {
        Ok(input) => {
            part_1(input);
            part_2(input);
        }
        Err(e) => println!("{}", e),
    };
}
