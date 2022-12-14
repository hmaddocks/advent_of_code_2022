use std::fs::File;
use std::io::{self, BufRead};

struct Section {
    start: i32,
    end: i32,
}

impl Section {
    pub fn overlaps(&self, other: &Section) -> bool {
        other.start == self.start || self.contains(other.start) || other.contains(self.start)
    }

    pub fn covers(&self, other: &Section) -> bool {
        self.start <= other.start && self.end >= other.end
    }

    pub fn contains(&self, x: i32) -> bool {
        x >= self.start && x <= self.end
    }
}

fn convert_to_section(line: String) -> (Section, Section) {
    let pairs: Vec<Vec<i32>> = line
        .split(',')
        .map(|x| x.split('-').map(|x| x.parse().unwrap()).collect())
        .collect();

    (
        Section {
            start: pairs[0][0],
            end: pairs[0][1],
        },
        Section {
            start: pairs[1][0],
            end: pairs[1][1],
        },
    )
}

fn main() {
    if let Ok(file) = File::open("../cleanup.txt") {
        let lines = io::BufReader::new(file).lines();
        let sections: Vec<(Section, Section)> = lines.flatten().map(convert_to_section).collect();

        let covers = sections
            .iter()
            .filter(|(left, right)| left.covers(right) || right.covers(left))
            .count();
        dbg!(covers);

        let overlaps = sections
            .iter()
            .filter(|(left, right)| left.overlaps(right))
            .count();
        dbg!(overlaps);
    }
}
