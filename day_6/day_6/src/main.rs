use itertools::Itertools;
use std::fs;

fn main() {
    match &fs::read("../signal.txt") {
        Ok(input) => {
            match String::from_utf8_lossy(input)
                .as_bytes()
                .windows(4)
                .position(|window| window.iter().unique().count() == 4)
                .map(|pos| pos + 4)
            {
                Some(pos) => println!("{}", pos),
                None => println!("None"),
            };
        }
        Err(e) => println!("{}", e),
    };

    println!("Hello, world!");
}
