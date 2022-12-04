use std::fs::File;
use std::io::{self, BufRead};

struct Section {
    start: i32,
    end: i32,
}

impl Section {
    pub fn overlaps(&self, other: &Section) -> bool {
        other.start == self.start || self.contains(other.start) || self.contains(other.start)
    }

    pub fn covers(&self, other: &Section) -> bool {
        self.start <= other.start && self.end >= other.end
    }

    pub fn contains(&self, x: i32) -> bool {
        x >= self.start && x <= self.end
    }
}

fn convert_to_section(line: String) -> (Section, Section) {
    let pairs: Vec<&str> = line.split(",").collect();
    let left: Vec<&str> = pairs[0].split("-").collect();
    let right: Vec<&str> = pairs[1].split("-").collect();
    let left_start = left[0].parse().unwrap();
    let left_end = left[1].parse().unwrap();
    let right_start = right[0].parse().unwrap();
    let right_end = right[1].parse().unwrap();
    (
        Section {
            start: left_start,
            end: left_end,
        },
        Section {
            start: right_start,
            end: right_end,
        },
    )
}

fn main() {
    if let Ok(file) = File::open("../cleanup.txt") {
        let lines = io::BufReader::new(file).lines();
        let sections: Vec<(Section, Section)> = lines
            .flatten()
            .map(|line| convert_to_section(line))
            .collect();

        let covers = sections.iter().fold(0, |acc, sections| {
            if sections.0.covers(&sections.1) || sections.1.covers(&sections.0) {
                acc + 1
            } else {
                acc
            }
        });
        dbg!(covers);

        let overlaps = sections.iter().fold(0, |acc, sections| {
            if sections.0.overlaps(&sections.1) || sections.1.overlaps(&sections.0) {
                acc + 1
            } else {
                acc
            }
        });
        dbg!(overlaps);
    }
}
